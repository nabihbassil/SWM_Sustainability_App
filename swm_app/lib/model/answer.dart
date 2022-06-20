import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// button of each answer
class Answer extends StatelessWidget {
  final String answerText;
  final Color borderColor;
  final VoidCallback answerTap;

  Answer(
      {required this.answerText,
      required this.borderColor,
      required this.answerTap});

  @SemanticsHintOverrides()
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(answerText,
            style: TextStyle(
              fontSize: 15.0,
            )),
      ),
    );
  }
}
