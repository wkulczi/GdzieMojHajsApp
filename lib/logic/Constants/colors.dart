import 'dart:ui';

class ColorStyles {
  static Color mainThemeBackgroundGradientStart = hexToColor("#43cea2");
  static Color mainThemeBackgroundGradientEnd = hexToColor("#185a9d");

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
