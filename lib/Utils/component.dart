import 'package:flutter/material.dart';

class HeightSizedBox extends StatelessWidget {
  final double height;
  const HeightSizedBox({
    Key? key,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
