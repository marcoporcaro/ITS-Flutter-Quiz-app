import 'package:flutter/material.dart';
import 'package:quiz/presentation/style/colors.dart';

class AnswerButton extends StatefulWidget {

  final String answer;
  final bool isCorrect;
  final VoidCallback onPressed;
  const AnswerButton({Key? key,
    required this.answer,
    required this.isCorrect,
    required this.onPressed}) : super(key: key);

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {

  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    var buttonColor = answerButtonColor;
    var textColor = answerButtonTextColor;
    if(hasBeenPressed) {
      textColor = answeredButtonTextColor;
      if(widget.isCorrect) {
        buttonColor = answerButtonColorRight;
      }
      else {
        buttonColor = answerButtonColorWrong;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              primary: buttonColor,
              onPrimary: textColor,
              elevation: 10,
            ),
            onPressed: () {
              setState(() {
                hasBeenPressed = true;
              });
              widget.onPressed();
            },
            child: Text(widget.answer,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),)
        ),
      ),
    );
  }
}
