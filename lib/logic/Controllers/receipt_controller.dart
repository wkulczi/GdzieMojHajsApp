import 'dart:convert';

import 'package:gdziemojhajsapp/logic/Constants/receipt_sort_type_enum.dart';

import 'package:gdziemojhajsapp/logic/Constants/ReceiptSortTypeEnum.dart';
import 'package:gdziemojhajsapp/logic/Entities/receipt.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/sort_receipts_bar.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/dashboard_menu.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class ReceiptController {
  static Future<http.Response> sendReceipt({ReceiptModel receipt}) async {
    final http.Response response = await http.post(
        MyApp.serverAddress +
            "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receipt.toJson()));
    return response;
  }

  static Future<ReceiptModel> getReceiptById(id) async {
    final http.Response response = await http.get(MyApp.serverAddress +
        "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}&id=$id");
    print(jsonDecode(response.body));
    return ReceiptModel.fromJson(jsonDecode(response.body));
  }

  static Future<List<Receipt>> getAccountsReceipts() async {
    var response = await http.get(MyApp.serverAddress +
        "/receipts?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}");

    if (response.statusCode != 200) {
      throw Exception("Get users receipts exc!");
    }

    List<Receipt> receiptsList = receiptsListMapping(response.body);

    print(SortReceiptsBar.isIncreasing);
    print(SortReceiptsBar.selectedReceiptsSortType);

    return sortReceipts(receiptsList, SortReceiptsBar.selectedReceiptsSortType,
        SortReceiptsBar.isIncreasing);
  }

  static Future<http.Response> updateReceipt({ReceiptModel receipt}) async {
    final http.Response response = await http.patch(
        MyApp.serverAddress +
            "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}&id=${receipt.id}",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receipt.toJson()));
    return response;
  }

  static Future<int> deleteReceipt(id) async {
    var response = await http.delete(MyApp.serverAddress +
        "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}&id=$id");
    return response.statusCode;
  }

  static List<Receipt> receiptsListMapping(String responseBody) {
    List<Receipt> receiptsList = [];
    for (var receipt in jsonDecode(responseBody)["receipts"]) {
      List<ProductModel> productsList = [];
      for (var product in receipt["products"]) {
        productsList.add(ProductModel.fromJson(product));
      }

      receiptsList.add(Receipt(
          id: receipt["id"].toString(),
          companyName: receipt["company"]["company_name"],
          categoryName: receipt["category"]["category_name"],
          sum: receipt["sum"],
          products: productsList));
    }
    return receiptsList;
  }

  static List<Receipt> sortReceipts(List<Receipt> receiptsList,
      ReceiptSortTypeEnum sortType, bool incremental) {
    if (sortType == ReceiptSortTypeEnum.cost) {
      receiptsList.sort((a, b) => a.sum.compareTo(b.sum));
    } else if (sortType == ReceiptSortTypeEnum.company_name) {
      receiptsList.sort((a, b) => a.companyName.compareTo(b.companyName));
    } else if (sortType == ReceiptSortTypeEnum.category_name) {
      receiptsList.sort((a, b) => a.categoryName.compareTo(b.categoryName));
    }

    if (!incremental) {
      List<Receipt> reversedList = List(receiptsList.length);
      for (int i = 0; i < receiptsList.length; i++) {
        reversedList[i] = receiptsList[receiptsList.length - 1 - i];
      }
      receiptsList = reversedList;
    }

    return receiptsList;
  }
}
