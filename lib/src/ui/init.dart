import 'package:flutter/material.dart';
import './components/textfieldBuilder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './doctor/homepage.dart';
import './patient/homepage.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  TextEditingController _namecontroller;
  TextEditingController _agecontroller;
  TextEditingController _profcontroller;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _agecontroller = TextEditingController();
    _profcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _agecontroller.dispose();
    _profcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Image.asset(
                    'assets/doc.png',
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldBuilder(
                  obt: false,
                  hintText: 'Name',
                  keyboard: TextInputType.text,
                  controllText: _namecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldBuilder(
                  obt: false,
                  hintText: 'Age',
                  keyboard: TextInputType.number,
                  controllText: _agecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldBuilder(
                  obt: false,
                  hintText: 'Doctor or Patient',
                  keyboard: TextInputType.text,
                  controllText: _profcontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Start',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () async {
                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      if (_pref.getString('name') == null &&
                          _pref.getString('age') == null &&
                          _pref.getString('profession') == null &&
                          _pref.getString('login') == null) {
                        _pref.setString('name', _namecontroller.text);
                        _pref.setString('age', _agecontroller.text);
                        _pref.setString('login', 'yes');
                        if (_profcontroller.text == 'Doctor') {
                          print('if running');
                          DocumentReference adding =
                              await Firestore.instance.collection('todo').add({
                            'name': _namecontroller.text,
                            'age': _agecontroller.text,
                          });
                          print(adding.documentID);
                          _pref.setString('docId', adding.documentID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorMode(),
                            ),
                          );
                        } else if (_profcontroller.text == 'Patient') {
                          var adding = await Firestore.instance
                              .collection('patientList')
                              .add({
                            'name': _namecontroller.text,
                            'age': _agecontroller.text,
                          });

                          _pref.setString('PatientId', adding.documentID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientMode(),
                            ),
                          );
                        }
                      } else {
                        print('else running');
                        print(_pref.getString('docId'));
                        print(_pref.getString('PatientId'));
                        if (_profcontroller.text == 'Doctor') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorMode(),
                            ),
                          );
                        } else if (_profcontroller.text == 'Patient') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientMode(),
                            ),
                          );
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
