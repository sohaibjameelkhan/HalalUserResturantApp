import 'package:flutter/material.dart';

class HeadingTextWidget extends StatelessWidget {
  final String headingtext;

  HeadingTextWidget({required this.headingtext});


  @override
  Widget build(BuildContext context) {
    return Text(
      headingtext, style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      fontSize: 23

    ),


    );
  }
}
