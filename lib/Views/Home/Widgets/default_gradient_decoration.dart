import 'package:flutter/cupertino.dart';
import 'package:gdziemojhajsapp/Constants/colors.dart';

defaultGradientDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: <Color>[ColorStyles.mainThemeBackgroundGradientStart, ColorStyles.mainThemeBackgroundGradientEnd],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.01, 1]),
  );
}
