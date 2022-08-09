import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/* 
  This component is used in screens/quiz_screen.dart. It's used to display each answer entry.

  Inputs:
  * answerText: contains the text of each answer.
  * answerTap: contains answer logic.

  Outputs:
  * Answer object containg the logic and box shape of the answer.
  
*/
class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback answerTap;

  const Answer({required this.answerText, required this.answerTap});

  @override
  @SemanticsHintOverrides()
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(answerText,
            style: const TextStyle(
              fontSize: 18.0,
            )),
      ),
    );
  }
}
