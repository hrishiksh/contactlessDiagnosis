import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/scheduleMod.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule extends StatefulWidget {
  final String docId;
  Schedule({this.docId});
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('todo')
          .document(widget.docId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data["todoList"] == null
              ? Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Please add some task',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              : SizedBox(
                  height: 400,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data["todoList"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: _slideRight(context),
                        secondaryBackground: _slideLeft(context),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            final bool res = await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                        'Do you want to delete this Item ?'),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () async {
                                        final SharedPreferences _pref =
                                            await SharedPreferences
                                                .getInstance();
                                        try {
                                          final document = Firestore.instance
                                              .collection('todo')
                                              .document(
                                                  _pref.getString('docId'));

                                          final data = await document.get();
                                          final List listdata =
                                              data["todoList"];

                                          final List finallist =
                                              listdata.removeAt(index);

                                          document.updateData({
                                            "todoList": finallist,
                                          });
                                        } catch (e) {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Can\'t connect now'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return res;
                          } else {
                            return null;
                          }
                        },
                        key: Key(scheduleList[index].text),
                        onDismissed: (direction) {},
                        child: ListTile(
                          leading: Checkbox(
                            value: snapshot.data["todoList"][index]["done"],
                            onChanged: (value) async {
                              try {
                                final SharedPreferences _pref =
                                    await SharedPreferences.getInstance();

                                final document = Firestore.instance
                                    .collection('todo')
                                    .document(_pref.getString('docId'));

                                final data = await document.get();
                                final List listdata = data["todoList"];

                                listdata[index]["done"] = value;

                                document.updateData({
                                  "todoList": listdata,
                                });
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Can\'t connect now'),
                                  ),
                                );
                              }
                            },
                          ),
                          title: Text(
                            snapshot.data["todoList"][index]["work"],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          return Container(
            child: Text(
              'Please add some task',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }
      },
    );
  }

  Widget _slideRight(context) {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              'Edit',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slideLeft(context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
