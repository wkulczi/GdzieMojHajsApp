import 'package:flutter/material.dart';
import 'package:pzapp/Category.dart';
import 'package:pzapp/categoryCard.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<Category> categories = [
    Category(name: "Jedzenie", image: 'images/jedzenie.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na jedzenie."),
    Category(name: "Relaks", image: 'images/relaks.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na relaks."),
    Category(name: "Odzież", image: 'images/odziez.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na odziez."),
    Category(name: "Sprzęt", image: 'images/sprzet.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na sprzęt."),
    Category(name: "Mieszkanie", image: 'images/mieszkanie.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na mieszkanie."),
    Category(name: "Transport", image: 'images/transport.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na transport."),
    Category(name: "Higiena", image: 'images/higiena.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na środki higieniczne."),
    Category(name: "Rachunki", image: 'images/rachunki.jpg', description: "W tej kategorii znajdują się dane dotyczace środków wydanych na rachunki."),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text("Kategorie"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: ListView(
        children: categories.map((category) =>  CategoryCard(category: category)).toList(),
      ),
    );
  }
}