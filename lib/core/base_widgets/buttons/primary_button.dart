import 'package:acak_soal/core/style/color.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends ElevatedButton {
  final String text;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  PrimaryButton(this.text,
      {this.padding = const EdgeInsets.symmetric(vertical: 10 , horizontal: 14), this.textStyle, super.key, super.onPressed})
      : super(
            child: Padding(
              padding: padding,
              child: Text(text, style: textStyle ?? TextStyle(color: ColorTheme.onPrimary)),
            ),
            style: ElevatedButton.styleFrom(primary: ColorTheme.primaryColor , elevation: 0 , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
