/*
This is the patient page without app bar
*/

import '../components/headerBar.dart';
import 'package:flutter/material.dart';
import '../components/headercard.dart';
import '../components/singleText.dart';
import '../components/reportView.dart';
import '../components/qrWidget.dart';
import 'package:page_indicator/page_indicator.dart';
import './testPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/msg.dart';

class PatientBody extends StatelessWidget {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ListView(
        children: <Widget>[
          HeaderBar(
            text: 'Feeling unwell?', //TODO
          ),
          SizedBox(
            height: 160,
            child: PageIndicatorContainer(
              length: 2,
              child: PageView(
                children: <Widget>[
                  HeaderCard(
                    headerText: 'Want Something Else?',
                    buttonText: 'Ask Now',
                    ontap: () async {
                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      final data = _pref.getString('PatientId');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Msg(
                            id: data,
                          ),
                        ),
                      );
                    },
                  ),
                  HeaderCard(
                    headerText: 'Start Daily Test?',
                    buttonText: 'Start Now',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              align: IndicatorAlign.bottom,
              indicatorSpace: 10,
              indicatorSelectorColor: Theme.of(context).cardColor,
              shape: IndicatorShape.circle(size: 7),
            ),
          ),
          SingleText(
            text: 'Daily Report',
          ),
          ReportView(),
          FutureBuilder(
            future: _pref,
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.hasData) {
                return QrWidget(
                  data: {
                    "name": snapshot.data.getString('name'),
                    "age": snapshot.data.getString('age'),
                    "admit": '20 dec',
                    "Last Message":
                        snapshot.data.getString('lastmsg') ?? 'No Msg',
                    "cough": snapshot.data.getString('cough') == 'yes'
                        ? true
                        : false,
                    "fever": snapshot.data.getString('fever') == 'yes'
                        ? true
                        : false,
                    "headache": snapshot.data.getString('headache') == 'yes'
                        ? true
                        : false,
                    "pneumonia": snapshot.data.getString('pnumonia') == 'yes'
                        ? true
                        : false,
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
