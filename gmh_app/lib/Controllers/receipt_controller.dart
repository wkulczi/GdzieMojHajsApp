import 'dart:convert';

import 'package:gmh_app/Models/receipt_model.dart';
import 'package:http/http.dart' as http;

class ReceiptController {
//  String IP = "46.41.149.135";
  String IP = "192.168.137.1";

  Future<ReceiptModel> getReceipt(id) async {
    final response = await http.get('http://192.168.137.1:5000/receipt');
    if (response.statusCode == 200) {
      print(response);
      return ReceiptModel.fromJson(json.decode(response.body));
    } else {
      print(response);
      print('err');
//      throw Exception('Failed to fetch receipt')
    }
  }
}
