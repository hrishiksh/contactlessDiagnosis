/* It contain all the detail of the patient*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatelessWidget {
  final DocumentSnapshot patient;

  Details({this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).accentColor,
              expandedHeight: 200,
              flexibleSpace: Center(
                child: SvgPicture.asset(
                  'assets/report.svg',
                  height: 150,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Name : ${patient.data["name"]}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Age : ${patient.data["age"]}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Admitted on : ${patient.data["admit"].toDate()}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Cough : ${patient.data["cough"] ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Fever : ${patient.data["fever"] ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Headache : ${patient.data["headache"] ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Text(
                      'Pneumonia : ${patient.data["pneumonia"] ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
