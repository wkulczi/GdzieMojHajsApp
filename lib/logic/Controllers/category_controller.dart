import 'dart:convert';

import 'package:gdziemojhajsapp/pages/Categories/Category.dart';
import 'package:http/http.dart';

import '../../main.dart';

class CategoryController{
  static Future<List> getData() async {
    Response response = await get(MyApp.serverAddress + '/categories');
    List data = jsonDecode(response.body);
//    print(data);
    return makeCategories(data);
  }

  static List makeCategories(List data){
    List<Category> categories = [];
    for (Map category in data){
      categories.add(
          Category(name: category['name'], description: category['description'],
              image: 'images/' + category['image'])
      );
    }
    return categories;
  }
}