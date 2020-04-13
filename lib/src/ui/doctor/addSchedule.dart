/*
Used to add todo to doctor
This is more a page than a component. But to use in another site we use this
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/textfieldBuilder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).appBarTheme.textTheme,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).cardColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Messenger',
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  'assets/report.svg',
                  height: 150,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: TextFieldBuilder(
                        obt: false,
                        keyboard: TextInputType.text,
                        controllText: _controller,
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Builder(
                    builder: (context) {
                      return InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor),
                        ),
                        onTap: () async {
                          final SharedPreferences _pref =
                              await SharedPreferences.getInstance();
                          try {
                            final document = Firestore.instance
                                .collection('todo')
                                .document(_pref.getString('docId'));

                            final data = await document.get();

                            if (data["todoList"] == null) {
                              document.setData({
                                "todoList": [
                                  {
                                    "done": false,
                                    "work": _controller.text,
                                  }
                                ]
                              });
                            } else {
                              final List listdata = data["todoList"];
                              listdata.add({
                                "done": false,
                                "work": _controller.text,
                              });
                              document.updateData(
                                {
                                  "todoList": listdata,
                                },
                              );
                            }

                            _controller.clear();
                            Navigator.pop(context);
                          } catch (e) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Can\'t connect now'),
                              ),
                            );
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
