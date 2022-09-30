import 'package:flutter/material.dart';
import 'package:quiz/question.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final List<Question> _questions = [
    Question(
        text: "Quanti nipoti ha Zio Paperone?",
        answers: ["3", "4", "0", "10"],
        correctAnswer: "3"
    ),
    Question(
        text: "Qual è la capitale della Francia?",
        answers: ["Roma", "Praga", "Parigi", "Tokio"],
        correctAnswer: "Parigi"
    ),
    Question(
        text: "Quanti sono i sette nani nella favola di Biancaneve?",
        answers: ["5", "7", "9"],
        correctAnswer: "7"
    ),
  ];

  void _goToNextQuestion() {
    if(_index >= _questions.length-1) return;
    setState(() {
      _index++;
    });
  }

  void _answerQuestion(String userAnswer) {
    if(_questions[_index].correctAnswer != userAnswer) return;
    _goToNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text(_questions[_index].text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _questions[_index].answers.map((answer) {
                  return Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => _answerQuestion(answer),
                        child: Text(answer)
                    ),
                  );
                }
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}