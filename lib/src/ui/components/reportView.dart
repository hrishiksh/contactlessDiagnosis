/*
This is for report view
TODO: we can use behaviour subject to capture last emitted value 
to update the cards and qr when value changes
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData &&
              snapshot.data.getString('headache') == null &&
              snapshot.data.getString('cough') == null &&
              snapshot.data.getString('fever') == null &&
              snapshot.data.getString('pneumonia') == null) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: cardGenerate(
                context: context,
                fever: 'Take Test',
                cough: 'Take Test',
                headache: 'Take Test',
                pneumonia: 'Take Test',
              ),
            );
          } else if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: cardGenerate(
                context: context,
                fever: snapshot.data.getString('fever'),
                cough: snapshot.data.getString('cough'),
                headache: snapshot.data.getString('headache'),
                pneumonia: snapshot.data.getString('pneumonia'),
              ),
            );
          } else {
            return CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            );
          }
        },
      ),
    );
  }

  List<Widget> cardGenerate(
      {context,
      String fever,
      String cough,
      String headache,
      String pneumonia}) {
    return [
      Cards(
        symptoms: 'Fever',
        situation: fever,
        svgpath: 'assets/thermo.svg',
      ),
      Cards(
        symptoms: 'Cough',
        situation: cough,
        svgpath: 'assets/cough.svg',
      ),
      Cards(
        symptoms: 'Headache',
        situation: headache,
        svgpath: 'assets/headache.svg',
      ),
      Cards(
        symptoms: 'Pneumonia',
        situation: pneumonia,
        svgpath: 'assets/lungs.svg',
      ),
    ];
  }
}

class Cards extends StatelessWidget {
  final String symptoms;
  final String situation;
  final String svgpath;

  Cards({this.symptoms, this.situation, this.svgpath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            symptoms,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            situation,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            svgpath,
            height: 100,
          ),
        ],
      ),
    );
  }
}
