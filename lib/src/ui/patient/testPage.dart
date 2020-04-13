import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/radioPair.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
//variable for results
  String kheadache = 'yes';
  String kcough = 'yes';
  String kfever = 'yes';
  String kpneumonia = 'yes';

//variable for Name and contact
  // TextEditingController namecontroller;
  // TextEditingController contactcontroller;

  @override
  void dispose() {
    // namecontroller.dispose();
    // contactcontroller.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  int _currentstep = 0;
  @override
  Widget build(BuildContext context) {
    Size sizedata = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text('Testing'),
                  elevation: 0,
                  expandedHeight: 300,
                  flexibleSpace: flexSpace(context),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Form(
                        key: _formkey,
                        child: Stepper(
                          physics: ClampingScrollPhysics(),
                          currentStep: _currentstep,
                          onStepCancel: () {
                            if (_currentstep != 0) {
                              setState(() {
                                _currentstep--;
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          onStepContinue: () async {
                            if (_currentstep <
                                steplistfunc(context, sizedata).length - 1) {
                              setState(() {
                                _currentstep++;
                              });
                            } else if (_currentstep ==
                                steplistfunc(context, sizedata).length - 1) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('processing...'),
                                ),
                              );
                              final prefs =
                                  await SharedPreferences.getInstance();
                              if (prefs.getString('headache') == null &&
                                  prefs.getString('cough') == null &&
                                  prefs.getString('fever') == null &&
                                  prefs.getString('pneumonia') == null) {
                                prefs.setString('headache', kheadache);
                                prefs.setString('cough', kcough);
                                prefs.setString('fever', kfever);
                                prefs.setString('pneumonia', kpneumonia);
                              } else {
                                await prefs.remove('headache');
                                await prefs.remove('cough');
                                await prefs.remove('fever');
                                await prefs.remove('pneumonia');
                                prefs.setString('headache', kheadache);
                                prefs.setString('cough', kcough);
                                prefs.setString('fever', kfever);
                                prefs.setString('pneumonia', kpneumonia);
                              }

                              try {
                                Firestore.instance
                                    .collection('patientList')
                                    .document(prefs.getString('PatientId'))
                                    .updateData({
                                  'cough': prefs.getString('cough') == 'yes'
                                      ? true
                                      : false,
                                  'fever': prefs.getString('fever') == 'yes'
                                      ? true
                                      : false,
                                  'headache':
                                      prefs.getString('headache') == 'yes'
                                          ? true
                                          : false,
                                  'pneumonia':
                                      prefs.getString('pneumonia') == 'yes'
                                          ? true
                                          : false,
                                });
                              } catch (e) {
                                print(e);
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertWidget();
                                },
                              );
                            }
                          },
                          steps: steplistfunc(context, sizedata),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget flexSpace(context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
      padding: EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
              'assets/test.svg',
              height: 180,
            ),
          ),
          Expanded(
              child: SizedBox(
            height: 20,
          )),
          Expanded(
            child: Container(
              child: Text(
                'This is for your own helth. please co-operate',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Step> steplistfunc(context, Size sizedata) {
    List<Step> steplist = [
      Step(
        title: Container(
          width: sizedata.width - 85,
          child: Text(
            'Do you have any headache?',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: RadioPair(
          groupvalue: kheadache,
          onChanged: (data) {
            setState(() {
              kheadache = data;
            });
          },
          firstValue: 'Yes',
          secondValue: 'No',
        ),
      ),
      Step(
        title: Container(
          width: sizedata.width - 85,
          child: Text(
            'Are you coughing regularly?',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: RadioPair(
          groupvalue: kcough,
          onChanged: (data) {
            setState(() {
              kcough = data;
            });
          },
          firstValue: 'Yes',
          secondValue: 'No',
        ),
      ),
      Step(
        title: Container(
          width: sizedata.width - 85,
          child: Text(
            'Do you have Fever',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: RadioPair(
          groupvalue: kfever,
          onChanged: (data) {
            setState(() {
              kfever = data;
            });
          },
          firstValue: 'Yes',
          secondValue: 'No',
        ),
      ),
      Step(
        title: Container(
          width: sizedata.width - 85,
          child: Text(
            'Do you have pneumonia?',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        content: RadioPair(
          groupvalue: kpneumonia,
          onChanged: (data) {
            setState(() {
              kpneumonia = data;
            });
          },
          firstValue: 'Yes',
          secondValue: 'No',
        ),
      ),
    ];
    return steplist;
  }
}
