/*
Used to send msg to doctor
This is more a page than a component. But to use in another site we use this
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/textfieldBuilder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Msg extends StatefulWidget {
  final String id;
  Msg({this.id});
  @override
  _MsgState createState() => _MsgState();
}

class _MsgState extends State<Msg> {
  TextEditingController _controller;
  ScrollController _scrollctrl;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollctrl = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollctrl.dispose();
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
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('patientList')
                    .document(widget.id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  Timer(
                    Duration(milliseconds: 100),
                    () => _scrollctrl
                        .jumpTo(_scrollctrl.position.maxScrollExtent),
                  );
                  if (snapshot.hasData) {
                    if (snapshot.data["msg"] != null) {
                      return ListView.builder(
                        controller: _scrollctrl,
                        itemCount: snapshot.data["msg"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: Theme.of(context).accentColor,
                              ),
                              child: Text(
                                snapshot.data["msg"][index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).accentColor,
                    ));
                  }
                },
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
                                .collection('patientList')
                                .document(widget.id);

                            final data = await document.get();
                            if (data["msg"] == null) {
                              document.setData({
                                "msg": [_controller.text]
                              });
                            } else {
                              final List listdata = data["msg"];
                              listdata.add(_controller.text);
                              document.updateData({
                                "msg": listdata,
                              });
                            }

                            if (_pref.getString('lastmsg') == null) {
                              _pref.setString('lastmsg', _controller.text);
                            } else {
                              _pref.remove('lastmsg');
                              _pref.setString('lastmsg', _controller.text);
                            }
                            _controller.clear();
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
