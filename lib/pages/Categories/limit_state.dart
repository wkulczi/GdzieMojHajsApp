import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/Categories/Category.dart';

class CategoriesState extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  set categories(List<Category> val){
    _categories = val;
    notifyListeners();
  }

  addAll(List<Category> val){
    _categories = val;
    notifyListeners();
  }

  changeLimit(String name, double val){
    for(Category cat in _categories){
      if(cat.name == name) cat.limit = val;
    }
    notifyListeners();
  }
  getLimit(String name){
    for(Category cat in _categories){
      if(cat.name == name) return cat.limit;
    }
  }
}