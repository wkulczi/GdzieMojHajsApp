import 'package:gdziemojhajsapp/Entities/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({String name, double price, int quantity}) : super(name: name, price: price, quantity: quantity);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  String showProduct() {
    return "<Product name: $name, Product price: $price, Product qty: $quantity>";
  }
}
