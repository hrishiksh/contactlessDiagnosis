/*This is for Scan QR code */

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../doctor/qrInit.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String barcode = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Scan a patient Now',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                ),
          ),
          IconButton(
            icon: Icon(
              Icons.launch,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrInit(),
                ),
              );
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
