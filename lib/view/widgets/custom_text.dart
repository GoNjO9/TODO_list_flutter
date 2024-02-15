import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? textColor;
  const CustomText({
    super.key,
    required this.text,
    this.textSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
      ),
    );
  }
}
