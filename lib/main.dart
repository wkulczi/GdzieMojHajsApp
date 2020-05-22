import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pzapp/limit_state.dart';
import 'package:pzapp/pages/categories.dart';
import 'package:pzapp/pages/categoryPage.dart';
import 'package:pzapp/pages/limit_transfer.dart';


void main() => runApp(ChangeNotifierProvider<CategoriesState>.value(
  value: CategoriesState(),
  child:   MaterialApp(
  
    routes: {
  
      '/': (context) => Categories(),
  
      '/category': (context) => CategoryPage(),

      '/limit_transfer': (context) => LimitTransfer()

    },
  
  ),
));


