import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color primaryColor = Color(0xff078B96);
  static final Color secondaryColor = Color(0xff03DAC5);
  static final Color textColor = Color.fromARGB(255, 248, 248, 248);
  static final Color bgColor = Color.fromARGB(255, 252, 252, 252);
  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: primaryColor,
    // Add other theme properties here
  );
}

class PrimaryTextStyle {
  static TextStyle primaryStyle = GoogleFonts.lato(
    fontSize: 16,
    color: Colors.white,
    // fontWeight: FontWeight.w500,
  );
  static TextStyle secondStyle = GoogleFonts.lato(
    fontSize: 14,
    color: Colors.white,
    // fontStyle: FontStyle.italic
    // fontWeight: FontWeight.w500,
  );
  static TextStyle judulStyle = GoogleFonts.lato(
    fontSize: 16,
    color: Color.fromARGB(255, 70, 70, 70),
    // fontStyle: FontStyle.italic
    fontWeight: FontWeight.bold,
  );
  static TextStyle subTxt = GoogleFonts.lato(
    fontSize: 12,
    color: Colors.black,
    // fontStyle: FontStyle.italic
    fontWeight: FontWeight.w500,
  );
}
