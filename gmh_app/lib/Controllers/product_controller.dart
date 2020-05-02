import 'dart:convert';

import 'package:gmh_app/Models/receipt_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<http.Response> sendReceipt({ReceiptModel receipt}) async {
    final http.Response response = await http.post('http://192.168.1.79:5000/receipt',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receipt.toJson()));
    return response;
  }
  //todo decode response, if 500 throw flushbar here or make this thing return boolean values
}
