import 'package:flutter/material.dart';

class RadioPair extends StatefulWidget {
  final void Function(String) onChanged;
  final String firstValue;
  final String secondValue;
  final String groupvalue;

  RadioPair(
      {this.onChanged, this.firstValue, this.secondValue, this.groupvalue});

  @override
  _RadioPairState createState() => _RadioPairState();
}

class _RadioPairState extends State<RadioPair> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: 'yes',
            groupValue: widget.groupvalue,
            onChanged: widget.onChanged,
          ),
          title: Text(
            widget.firstValue,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Color(
                    0xFF575757,
                  ),
                ),
          ),
        ),
        ListTile(
          leading: Radio(
            value: 'no',
            groupValue: widget.groupvalue,
            onChanged: widget.onChanged,
          ),
          title: Text(
            widget.secondValue,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Color(
                    0xFF575757,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
