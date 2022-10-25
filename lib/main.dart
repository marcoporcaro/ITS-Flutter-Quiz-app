import 'package:flutter/material.dart';
import 'package:quiz/presentation/home/home_page.dart';
import 'package:quiz/presentation/question/question_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
        QuestionPage.route: (context) => const QuestionPage()
      },
      initialRoute: HomePage.route,
    );
  }
}


