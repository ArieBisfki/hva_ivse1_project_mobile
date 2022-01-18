import 'package:flutter/material.dart';

class CostumTextField extends StatelessWidget {
  const CostumTextField(
      {Key? key,
      required this.controller,
      this.validate = false,
      required this.text,
      this.obscure = false})
      : super(key: key);

  final TextEditingController controller;
  final bool validate;
  final bool obscure;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
          errorText: validate ? 'Value Can\'t Be Empty' : null,
        ),
      ),
    );
  }
}
