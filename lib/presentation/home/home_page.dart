import 'package:flutter/material.dart';
import 'package:quiz/presentation/question/question_category.dart';
import 'package:quiz/presentation/question/question_difficulty.dart';
import 'package:quiz/presentation/question/question_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: QuestionCategory.values.length,
          itemBuilder: (context, index) =>
              ElevatedButton(
                child: Text(QuestionCategory.values[index].getDisplayName()),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          QuestionPage(title: "Quiz", category: QuestionCategory.values[index].getCategoryValue(),))
                  );
                },
              )
      ),
    );
  }
}
