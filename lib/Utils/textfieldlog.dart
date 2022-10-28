import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Icon icon;
  final TextEditingController controller;
  final TextInputType textInputType;
  bool isObscure;
  CustomTextField(
      {Key? key,
      required this.title,
      required this.icon,
      required this.controller,
      this.isObscure = false,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            keyboardType: textInputType,
            obscureText: isObscure,
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: icon, hintText: title, border: InputBorder.none),
          ),
        ));
  }
}
