import 'package:flutter/material.dart';

class LimitsState extends ChangeNotifier {
  double _monthly = 0.0;
  double _daily = 0.0;
  double _minus_daily = 0.0;
  double _subtract = 0.0;

  set monthly(double val){
    _monthly = val;
    notifyListeners();
  }

  set daily(double val){
    _daily = val;
    notifyListeners();
  }

  set minus_daily(double val){
    _minus_daily = val;
    notifyListeners();
  }

  set subtract(double val){
    _subtract = val;
    notifyListeners();
  }

  changeMonthly(double val){
    _monthly = val;
    notifyListeners();
  }

  changeDaily(double val){
    _daily = val;
    notifyListeners();
  }

  changeMinusDaily(double val){
    _minus_daily = val;
    notifyListeners();
  }

  changeSubtract(double val){
    _subtract = val;
    notifyListeners();
  }

  getMonthly(){
    return _monthly;
  }

  getDaily(){
    return _daily;
  }

  getMinusDaily(){
    return _minus_daily;
  }

  getSubtract(){
    return _subtract;
  }
}