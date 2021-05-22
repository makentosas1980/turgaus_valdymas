import 'package:flutter/material.dart';

class RichTextData extends StatelessWidget {
  final String labelTitle;
  final String labelData;

  RichTextData({this.labelTitle, this.labelData});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: labelTitle,
        style: TextStyle(
            fontStyle: FontStyle.italic, fontSize: 24, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: labelData,
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
