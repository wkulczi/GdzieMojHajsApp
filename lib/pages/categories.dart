import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/Category.dart';
import 'package:gdziemojhajsapp/pages/categoryCard.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Categories extends StatefulWidget {
  static String tag = "categories";
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List data = [];
  List<Category> categories = [];

  void getData() async {
    Response response = await get('http://10.0.2.2:5000/categories');
    data = jsonDecode(response.body);
    print(data[0]['name']);
    makeCategories();
  }

  void makeCategories(){
    for (Map category in data){
      categories.add(
          Category(name: category['name'], description: category['description'],
              image: 'images/' + category['image'])
      );
    }
    print(categories[0]);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


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