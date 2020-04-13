import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  final String hintText;
  final TextInputType keyboard;
  final TextEditingController controllText;
  final void Function(String) onChanged;
  final bool obt;
  final String errorText;

  TextFieldBuilder({
    this.hintText,
    this.keyboard,
    this.controllText,
    this.onChanged,
    @required this.obt,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obt,
      controller: controllText,
      keyboardType: keyboard,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        hintText: hintText,
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.red),
      ),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Color(
              0xFF575757,
            ),
          ),
      onChanged: onChanged,
    );
  }
}
