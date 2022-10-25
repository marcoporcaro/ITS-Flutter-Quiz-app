import 'package:flutter/material.dart';
import 'package:quiz/presentation/question/question_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("Go to questions"),
        onPressed: () {
            Navigator.push(
                context,
              MaterialPageRoute(
                  builder: (context) => const QuestionPage(title: "Quiz"))
            );
        },
      ),
    );
  }
}
