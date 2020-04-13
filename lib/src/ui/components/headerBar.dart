/*This is for header dark bar used for notification*/

import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final String text;
  final void Function(bool) onchanged;

  HeaderBar({this.text, this.onchanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
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
            text,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                ),
          ),
          Switch(
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            activeColor: Theme.of(context).accentColor,
            value: false,
            onChanged: onchanged,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
