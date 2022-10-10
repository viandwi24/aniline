import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORS SCHEME
const Color kPrimaryColor = Color(0xFF28ABB9);
const Color kBackgroundColor = Color(0xFF181A20);
const Color kTextColor = Colors.white;
const Color kYellowColor = Color(0xFFFFEEC3);
const Color kPinkColor = Color(0xFFFF6FB5);
const Color kTealColor = Color(0xFF55D8C1);

// THEME DATA
final TextTheme kDefaultTextTheme = TextTheme(
  button: GoogleFonts.nunitoSans(
    textStyle: const TextStyle(
      fontSize: 20,
      color: kTextColor,
    ),
  ),
  bodyText1: GoogleFonts.nunitoSans(
    textStyle: const TextStyle(
      fontSize: 14,
      color: kTextColor,
    ),
  ),
  bodyText2: GoogleFonts.nunitoSans(
    textStyle: const TextStyle(
      fontSize: 14,
      color: kTextColor,
    ),
  ),
);
