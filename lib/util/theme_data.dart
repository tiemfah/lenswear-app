import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ThemeData lenswearThemeData = ThemeData(
//   primaryColor: primaryColor,
//   primaryColorLight: primaryColor,
//   primaryColorDark: const Color(0xFFbcc8d0),
//   accentColor: accentColor,
//   canvasColor: Colors.transparent,
// );

ThemeData lenswearThemeData = ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: primaryColor,
    canvasColor: Colors.transparent,
    fontFamily: GoogleFonts.robotoMono().fontFamily);

Color primaryColor = const Color(0xFFFAF7F7);
Color secondaryColor = const Color(0xFFBCBCBC);
Color accentColor = const Color(0xFF1F1300);
Color brightColor = const Color(0xFFED9E8D);
Color primaryComplementaryColor = const Color(0xFFE6D5E3);
Color secondaryComplementaryColor = const Color(0xFFE4D6CE);
Color greenColor = const Color(0xFF00A878);
Color redColor = const Color(0xFFC20038);
Color blueColor = const Color(0xFF3777FF);

TextStyle minorTextStyle = TextStyle(color: accentColor, fontSize: 14);
TextStyle majorTextStyle = TextStyle(color: accentColor, fontSize: 36);
TextStyle minorHighLightedTextStyle =
    TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle buttonHighLightedTextStyle =
    TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle basketItemTextStyle = TextStyle(fontSize: 20, color: accentColor);

InputDecoration textFieldStyle = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: accentColor),
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    filled: true,
    fillColor: secondaryColor,
    hintStyle: minorTextStyle);

List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.7),
    offset: const Offset(-10, -10),
    blurRadius: 15,
  ),
  BoxShadow(
    color: secondaryColor,
    offset: const Offset(15, 15),
    blurRadius: 30,
  )
];

List<BoxShadow> navBarShadow = [
  BoxShadow(
    color: secondaryColor.withOpacity(0.5),
    offset: const Offset(0, -10),
    blurRadius: 40,
  ),
  BoxShadow(
    color: Colors.white.withOpacity(0.7),
    offset: const Offset(0, 15),
    blurRadius: 30,
  )
];
