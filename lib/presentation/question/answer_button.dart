import 'package:flutter/material.dart';
import 'package:quiz/presentation/style/colors.dart';

class AnswerButton extends StatelessWidget {

  final String answer;
  final AnswerState answerState;
  final VoidCallback onPressed;

  const AnswerButton({Key? key,
    required this.answer,
    required this.answerState,
    required this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var buttonColor = answerButtonColor;
    var textColor = answerButtonTextColor;

    switch(answerState) {
      case AnswerState.correct:
        buttonColor = answerButtonColorRight;
        textColor = answeredButtonTextColor;
        break;
      case AnswerState.wrong:
        buttonColor = answerButtonColorWrong;
        textColor = answeredButtonTextColor;
        break;
      case AnswerState.none:
        buttonColor = answerButtonColor;
        textColor = answerButtonTextColor;
        break;
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
            onPressed: onPressed,
            child: Text(answer,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),)
        ),
      ),
    );
  }
}

enum AnswerState {
  correct,
  wrong,
  none
}
