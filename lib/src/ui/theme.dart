import 'package:flutter/material.dart';

Map<String, ThemeData> themes = {
  "light": ThemeData.light().copyWith(
    brightness: Brightness.light,
    accentColor: Color(0xFFFF6584),
    cardColor: Color(0xFF575757),

    /*Here we define the app bar*/
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      elevation: 8,
      color: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black54,
        ),
      ),
    ),
    // Here goes all the text Themes
    textTheme: TextTheme(
      //This is general purpose text
      headline5: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Color(0xFF575757),
      ),
      // This is for titles
      headline6: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF575757),
      ),
      //This is for small Data points
      subtitle1: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        color: Color(0xFF575757),
      ),
      //This is for buttuns
      subtitle2: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Color(0xFF575757),
      ),
    ),
  )
};
