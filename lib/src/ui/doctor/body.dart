import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/headerBar.dart';
import '../components/scanqr.dart';
import '../components/singleText.dart';
import '../components/schedule.dart';
import '../components/qrWidget.dart';

class DoctorBody extends StatefulWidget {
  @override
  _DoctorBodyState createState() => _DoctorBodyState();
}

class _DoctorBodyState extends State<DoctorBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ListView(
        children: <Widget>[
          HeaderBar(
            text: 'On Duty ?', onchanged: null, //TODO
          ),
          ScanQR(),
          SingleText(
            text: 'Schedule Task',
          ),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.hasData) {
                return Schedule(
                  docId: snapshot.data.getString('docId'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          QrWidget(data: {"name": "doctor"}),
        ],
      ),
    );
  }
}
