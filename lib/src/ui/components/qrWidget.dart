import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  QrWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            'assets/padometer.svg',
            height: 100,
          ),
          Container(
            child: QrImage(
              data: jsonEncode(data),
              version: QrVersions.auto,
              size: 100,
              gapless: false,
            ),
          ),
        ],
      ),
    );
  }
}
