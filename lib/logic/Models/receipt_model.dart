import 'package:flutter/cupertino.dart';
import 'package:gdziemojhajsapp/logic/Entities/receipt.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'receipt_model.g.dart';

@JsonSerializable()
class ReceiptModel extends Receipt {
  ReceiptModel({String id, @required String companyName, @required String categoryName, @required List<ProductModel> products, @required double sum})
      : super(id: id, companyName: companyName, categoryName: categoryName, products: products, sum: sum);

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => _$ReceiptModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);

  //for debugging
  String showModel() {
    String _productsListToString = "";
    for (var product in products) {
      _productsListToString += product.showProduct();
    }
    return "Shop name: $companyName, Category name: $categoryName, products: $_productsListToString, sum: $sum>";
  }
}
