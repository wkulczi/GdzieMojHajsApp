import 'package:flutter/material.dart';
import 'package:pzapp/pages/categories.dart';
import 'package:pzapp/pages/categoryPage.dart';


void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Categories(),
    '/category': (context) => CategoryPage()
  },
));


