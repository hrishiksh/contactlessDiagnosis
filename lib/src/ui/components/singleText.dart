/*
This for Single text line with padding
*/

import 'package:flutter/material.dart';

class SingleText extends StatelessWidget {
  final String text;
  SingleText({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
