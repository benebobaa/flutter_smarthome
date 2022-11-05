import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color primaryColor = HexColor("A6A5FF");
Color card1 = HexColor("F99999");
Color card2 = HexColor("8163FA");
Color card3 = HexColor("EFE698");
Color card4 = HexColor("98E0B5");
Color lightblue = HexColor("D3D2FF");
