import 'package:flutter/material.dart';
import './body.dart';

/*
This is the home view of patient. We use many widget from components folder.

*/

class PatientMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).appBarTheme.textTheme,
        title: Text(
          'Helping Hand',
        ),
      ),
      body: PatientBody(),
    );
  }
}
