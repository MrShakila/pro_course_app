import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightSizedBox extends StatelessWidget {
  final double height;
  const HeightSizedBox({
    Key? key,
    this.height = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class Formtextfield extends StatelessWidget {
  final TextEditingController cotrollers;
  final String label;
  final bool isSecure;
  final String hinttext;
  const Formtextfield({
    Key? key,
    required this.label,
    this.isSecure = false,
    required this.hinttext,
    required this.cotrollers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
          enableSuggestions: true,
          obscureText: isSecure,
          controller: cotrollers,
          decoration: InputDecoration(
              labelText: label,
              hintText: hinttext,
              labelStyle: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 15,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)))),
    );
  }
}
