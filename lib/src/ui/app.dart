/*
This file include material conuterpart. All the themes are defined here

*/

import './doctor/homepage.dart';
import 'package:flutter/material.dart';
import './patient/homepage.dart';
import 'theme.dart';
import 'init.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Init(),
      /*
      Here we define our themes.
      I am tring to make it light and dark theme both
      Lets define both the theme in theme.dart file
      */

      theme: themes["light"],
    );
  }
}
