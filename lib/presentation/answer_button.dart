import 'package:flutter/material.dart';
import 'package:quiz/presentation/style/colors.dart';

class AnswerButton extends StatelessWidget {

  final String answer;
  final VoidCallback onPressed;
  const AnswerButton({Key? key, required this.answer, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              primary: answerButtonColor,
              onPrimary:answerButtonTextColor,
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
