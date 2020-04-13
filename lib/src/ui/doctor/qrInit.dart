/*
This screen give the result of qr scan
*/
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/scanqr.dart';

class QrInit extends StatefulWidget {
  @override
  _QrInitState createState() => _QrInitState();
}

class _QrInitState extends State<QrInit> {
  String barcode = '';
  var data;

  @override
  Widget build(BuildContext context) {
    if (barcode != '') {
      data = jsonDecode(barcode);
    }
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).accentColor,
              expandedHeight: 250,
              flexibleSpace: Center(
                child: SvgPicture.asset(
                  'assets/report.svg',
                  height: 150,
                ),
              ),
            ),
            barcode == ''
                ? SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * .2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/scan.svg',
                            height: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Please scan a qr code',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Name : ${data["name"]}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Age : ${data["age"]}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        //TODO Add the admit
                        // Container(
                        //   padding:
                        //       EdgeInsets.only(top: 20, left: 30, right: 20),
                        //   child: Text(
                        //     'Admitted on : ${data["age"]}',
                        //     style: Theme.of(context).textTheme.headline5,
                        //   ),
                        // ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Cough : ${data["cough"] == true ? 'Yes' : 'No'}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Fever : ${data["fever"] == true ? 'Yes' : 'No'}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Headache : ${data["headache"] == true ? 'Yes' : 'No'}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),

                        Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 20),
                          child: Text(
                            'Pneumonia : ${data["pneumonia"] == true ? 'Yes' : 'No'}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await scan();
          print(barcode);
        },
        child: Icon(Icons.image),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } catch (e) {
      print(e);
      // setState(() => this.barcode = 'Unknown error: $e');

    }
    //on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.CameraAccessDenied) =>null{

    //     // setState(() {
    //     //   this.barcode = 'The user did not grant the camera permission!';
    //     // });
    //   } else {
    //     // setState(() => this.barcode = 'Unknown error: $e');
    //   }
    // } on FormatException {
    //   // setState(() => this.barcode =
    //   //     'null (User returned using the "back"-button before scanning anything. Result)');
  }
}
