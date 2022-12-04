import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORS SCHEME
const Color kPrimaryColor = Color(0xFF00B6F0);
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kBackgroundSecondaryColor = Color.fromARGB(255, 238, 238, 238);
const Color kTextColor = Color(0xFF272728);
const Color kTextLightColor = Color(0xFFFFFFFF);
const Color kYellowColor = Color(0xFFFFEEC3);
const Color kPinkColor = Color(0xFFFF6FB5);
const Color kTealColor = Color(0xFF55D8C1);
const Color kShimmerColor = Color(0xFFE0E0E0);

// THEME DATA
final TextTheme kDefaultTextTheme = TextTheme(
  button: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 20,
      color: kTextColor,
    ),
  ),
  bodyText1: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14,
      color: kTextColor,
    ),
  ),
  bodyText2: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14,
      color: kTextColor,
    ),
  ),
  headline1: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    ),
  ),
  headline2: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    ),
  ),
  headline3: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    ),
  ),
  headline4: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    ),
  ),
  headline5: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    ),
  ),
  headline6: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: kTextColor,
    ),
  ),
  caption: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: kTextColor,
    ),
  ),
  labelMedium: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: kTextColor,
    ),
  ),
);
