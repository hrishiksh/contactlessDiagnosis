import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String headerText;
  final String buttonText;
  final void Function() ontap;

  HeaderCard({this.headerText, this.buttonText, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headerText,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(buttonText,
                  style: Theme.of(context).textTheme.subtitle2),
            ),
            onTap: ontap,
          ),
        ],
      ),
    );
  }
}
