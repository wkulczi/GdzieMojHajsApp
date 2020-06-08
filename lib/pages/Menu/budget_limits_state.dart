import 'package:flutter/material.dart';

class LimitsState extends ChangeNotifier {
  double _monthly = 0.0;
  double _daily = 0.0;
  double _daily_left = 0.0;
  double _monthly_left = 0.0;

  set monthly(double val){
    _monthly = val;
    notifyListeners();
  }

  set daily(double val){
    _daily = val;
    notifyListeners();
  }

  set daily_left(double val){
    _daily_left = val;
    notifyListeners();
  }

  set monthly_left(double val){
    _monthly_left = val;
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

  changeDailyLeft(double val){
    _daily_left = val;
    notifyListeners();
  }

  changeMonthlyLeft(double val){
    _monthly_left = val;
    notifyListeners();
  }

  getMonthly(){
    return _monthly;
  }

  getDaily(){
    return _daily;
  }

  getDailyLeft(){
    return _daily_left;
  }

  getMonthlyLeft(){
    return _monthly_left;
  }
}