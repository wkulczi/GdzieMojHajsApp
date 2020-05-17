import 'dart:convert';

import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class ReceiptController {
//  String IP = "46.41.149.135";
  String IP = "192.168.1.79";

  Future<http.Response> sendReceipt({ReceiptModel receipt}) async {

    final http.Response response = await http.post(MyApp.serverAddress +
        "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receipt.toJson()));
    return response;
  }

  Future<ReceiptModel> getReceipt(id) async {
    final response = await http.get('http://192.168.1.79:5000/receipt');
    if (response.statusCode == 200) {
      print(response);
      return ReceiptModel.fromJson(json.decode(response.body));
    } else {
      print(response);
      print('err');
//      throw Exception('Failed to fetch receipt')
    }
  }

  static Future<List<Map>> getAllAccountsReceipts() async {
    var response = await http.get(MyApp.serverAddress +
        "/receipts?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}");

    Map receiptsMap;

    if (response.statusCode == 200) {
      receiptsMap = jsonDecode(response.body);
    } else {
      throw Exception("Get users receipts error!");
    }

    List<Map> mappedList = receiptsListMapping(receiptsMap);

    return mappedList;
  }

  static List<Map> receiptsListMapping(Map receiptsMap) {
    List<Map> result = [];

    print(receiptsMap);

    if (receiptsMap.isEmpty) {
      return null;
    }

    for (var receipt in receiptsMap["receipts"]) {
      String companyName = receipt["company"]["company_name"];
      double sum = receipt["sum"];

//      for (var receipt_product in receipt["receipt_product"]) {
//        sum +=
//            receipt_product["quantity"] * receipt_product["product"]["price"];
//      }

      result.add({"companyName": companyName, "sum": sum.toStringAsFixed(2)});
    }

    return result;
  }
}
