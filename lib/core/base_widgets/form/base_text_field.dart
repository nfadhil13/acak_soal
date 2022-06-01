import 'package:acak_soal/core/style/color.dart';
import 'package:flutter/material.dart';

class BaseTextFormField extends TextFormField {
  final String? hintText;
  BaseTextFormField({super.key, super.autocorrect, this.hintText, super.keyboardType, super.inputFormatters, super.onSaved, super.validator})
      : super(
            cursorColor: ColorTheme.primaryColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorTheme.primaryColor, width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorTheme.primaryColor, width: 2.0),
              ),
              hintText: hintText,
          
            ));
}
