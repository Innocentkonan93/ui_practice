import 'package:flutter/material.dart';

typedef ColorInfo = ({Color color, int shade});

// * These colors are the data source for the PageView and ListView
class RainbowColors {
  static const colors = [
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
  ];

  static List<ColorInfo> generate() {
    final allColors = <ColorInfo>{};
    for (var color in colors) {
      for (var key in color.keys) {
        allColors.add((color: color[key]!, shade: key));
      }
    }
    return allColors.toList();
  }
}
