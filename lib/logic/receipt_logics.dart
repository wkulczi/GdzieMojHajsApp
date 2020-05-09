import 'dart:convert';

import '../main.dart';
import 'package:http/http.dart' as http;

Future<Map> getUsersReceipts() async {
  var response = await http.get(MyApp.serverAddress +
      "/receipts?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}");

  Map receiptsMap;

  if (response.statusCode == 200) {
    receiptsMap = jsonDecode(response.body);
  } else {
    throw Exception("Get users receipts error!");
  }

  return receiptsMap;
}

Future<List<Map>> getUserReceiptsOverview() async {
  var receiptsMap = await getUsersReceipts();
  List<Map> result = [];

  print(receiptsMap);

  if (receiptsMap.isEmpty) {
    return null;
  }

  for (var receipt in receiptsMap["receipts"]) {
    String companyName = receipt["company"]["name"];
    double sum = 0;

    for (var receipt_product in receipt["receipt_product"]) {
      sum += receipt_product["quantity"] * receipt_product["product"]["price"];
    }

    result.add({"companyName": companyName, "sum": sum.toStringAsFixed(2)});
  }

  return result;
}
