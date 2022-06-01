import 'package:acak_soal/core/style/color.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Widget? widget;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final void Function()? onPress;

  const SecondaryButton(this.text,
      {super.key,
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      this.textStyle,
      this.widget,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorTheme.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: padding,
            child: widget?? Text(text,
                style: textStyle ?? TextStyle(color: ColorTheme.primaryColor)),
          )),
    );
  }
}
