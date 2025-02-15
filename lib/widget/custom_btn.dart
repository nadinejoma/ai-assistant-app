import '../main.dart';
import 'package:flutter/material.dart';

import '../helper/global.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color; // Background color of the button

  const CustomBtn({
    super.key,
    required this.onTap,
    required this.text,
    this.color = Colors.purpleAccent, // Default color is purpleAccent
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          minimumSize: Size(mq.width * .4, 50),
          backgroundColor: Theme.of(context).buttonColor,
        ),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
