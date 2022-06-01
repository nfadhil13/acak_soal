
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme extends TextTheme {
  AppTextTheme()
      : super(
          headline1: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 32,
          ),
          headline2: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 25,
            letterSpacing: 0,
          ),
          headline3: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            letterSpacing: 0.01,
          ),
          headline6: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 8,
            letterSpacing: 0.12,
          ),
          button: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            letterSpacing: 1.25,
          ),
          subtitle1: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0.15,
          ),
          bodyText1: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
          bodyText2: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            letterSpacing: 0.25,
          ),
          caption: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 10,
            letterSpacing: 0.01,
          ),
        );
}
