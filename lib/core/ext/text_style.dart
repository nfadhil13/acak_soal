import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle copyWithColor(Color color) => copyWith(color : color);
} 