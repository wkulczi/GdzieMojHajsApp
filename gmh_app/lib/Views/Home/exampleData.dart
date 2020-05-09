import 'package:gmh_app/Entities/product.dart';
import 'package:gmh_app/Models/product_model.dart';
import 'package:gmh_app/Models/receipt_model.dart';


class exampleData{
  static List<ReceiptModel> receipts = [
    ReceiptModel(
        categoryName: "Spożywcze",
        id: '1',
        shopName: "Biedronka",
        sum: 20.21,
        products: [
          ProductModel(name: "Czipsy", price: 20, quantity: 1),
          ProductModel(name: "Pićko", price: 1, quantity: 1)
        ]),
    ReceiptModel(
        categoryName: "Rozrywka",
        id: '2',
        shopName: 'Restauracja Zdolni',
        sum: 52.30,
        products: [
          ProductModel(name: "Ziemniaki", price: 9, quantity: 1),
          ProductModel(name: "Drineczek", price: 12, quantity: 3)
        ]),
    ReceiptModel(
        categoryName: "Inne",
        shopName: "Sklep Papierniczy Marek i nożyczki",
        sum: 12.99,
        products: []
    ),
    ReceiptModel(
        categoryName: "Transport",
        shopName: "MPK Poznań",
        sum: 138.00,
        products: []
    ),
    ReceiptModel(
        categoryName: "Rozrywka",
        shopName: "Projekt LAB",
        sum: 72.30,
        products: []
    ),
    ReceiptModel(
        categoryName: "Rozrywka",
        shopName: "Kawiarnia \"Czarna Kawa\"",
        sum: 32.85,
        products: []
    ),
    ReceiptModel(
        categoryName: "Rozrywka",
        shopName: "Kawiarnia \"Czarna Kawa\"",
        sum: 32.85,
        products: []
    )
  ];

}
