import 'dart:convert';

import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class ProductController {
  Future<http.Response> sendReceipt({ReceiptModel receipt}) async {

    final http.Response response = await http.post(MyApp.serverAddress +
        "/receipt?login=${MyApp.activeUser["login"]}&password=${MyApp.activeUser["password"]}",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receipt.toJson()));
    return response;
  }
  //todo decode response, if 500 throw flushbar here or make this thing return boolean values
}
