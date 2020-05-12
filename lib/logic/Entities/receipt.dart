import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';

class Receipt extends Equatable {
  String id;
  String companyName;
  String categoryName;
  List<ProductModel> products;
  double sum;

  Receipt({@required this.id, @required this.companyName, @required this.categoryName, @required this.sum, @required this.products});


  @override
  List<Object> get props => [id, companyName, categoryName, products, sum];
}
