import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String name;
  double price;
  int quantity;

  Product({this.name, this.price, this.quantity});

  @override
  List<Object> get props => [name, price, quantity];
}
