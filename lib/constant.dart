import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORS SCHEME
const Color kPrimaryColor = Color(0xFF00B6F0);
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kBackgroundSecondaryColor = Color(0xFFF8FAFB);
const Color kTextColor = Color(0xFF272728);
const Color kTextLightColor = Color(0xFFFFFFFF);
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
