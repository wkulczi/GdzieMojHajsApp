import 'dart:convert';

import 'package:gdziemojhajsapp/logic/Entities/Category.dart';
import 'package:http/http.dart';

import '../../main.dart';

class CategoryController{
  static Future<List> getData() async {
    Response response = await get(MyApp.serverAddress + '/categories');
    List data = jsonDecode(response.body);
//    print(data);
    return makeCategories(data);
  }

  static Future<double> getSpent(name) async {
    Response response = await get(MyApp.serverAddress + '/category_spent?category_name=' + name);
    double data = jsonDecode(response.body);
    if(data==null) data = 0;
    return data;
  }

  static Future<List> makeCategories(List data) async {
    List<Category> categories = [];
    for (Map category in data){
      categories.add(
          Category(name: category['name'], name_eng: category['name_eng'], description: category['description'],
              image: 'images/' + category['image'], spent: await getSpent(category['name_eng']))
      );
    }
    return categories;
  }

  static Future<double> getSpentAll() async {
    Response response = await get(MyApp.serverAddress + '/money_spent');
    double data = jsonDecode(response.body);
    if(data==null) data = 0;
    return data;
  }

}