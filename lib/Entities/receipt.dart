import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/Models/product_model.dart';

class Receipt extends Equatable {
  String id;
  String shopName;
  String categoryName;
  List<ProductModel> products;
  double sum;

  Receipt({@required this.id, @required this.shopName, @required this.categoryName, @required this.sum, @required this.products});

  @override
  List<Object> get props => [id, shopName, categoryName, products, sum];
}
