import 'package:flutter/material.dart';
import 'package:quiz/presentation/question/question_page.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text("Go to questions"),
          onPressed: () {
            Navigator.pushNamed(context, QuestionPage.route, arguments: "Ciao");
          },
        ),
      ),
    );

  }
}
