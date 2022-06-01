import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../style/color.dart';

class FormWrapper extends StatelessWidget {
  final Widget child;
  const FormWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Text("KELOMPOK TA - 313",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 32,
                color: ColorTheme.onPrimary)),
        const SizedBox(height: 50),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: child)
      ],
    );
  }
}
