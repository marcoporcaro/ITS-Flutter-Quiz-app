import 'package:flutter/material.dart';
import 'package:quiz/presentation/answer_button.dart';
import 'package:quiz/presentation/question_bloc.dart';
import 'package:quiz/presentation/style/colors.dart';

import '../domain/entity/question_entity.dart';


class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _index = 0;
  final QuestionBloc _questionBloc = QuestionBloc();
  List<QuestionEntity> _questions = [];


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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundTopColor, backgroundBottomColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<List<QuestionEntity>>(
            future: _questionBloc.getQuestions(),
            builder: (BuildContext context, AsyncSnapshot<List<QuestionEntity>> snapshot) {
              if(snapshot.connectionState != ConnectionState.done || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              _questions = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:
                  Image.asset("assets/images/quiz_image.png",
                    scale: 0.5,
                  )),
                  Text("question ${_index+1} of ${_questions.length}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: questionIndexColor,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(_questions[_index].text!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: questionColor,
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _questions[_index].answers!.map((answer) {
                      return AnswerButton(
                        answer: answer,
                        onPressed: () => _answerQuestion(answer),
                      );
                    }
                    ).toList(),
                  ),
                  const SizedBox(height: 20,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}