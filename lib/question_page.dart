import 'package:flutter/material.dart';
import 'package:quiz/question.dart';
import 'package:quiz/question_bloc.dart';


class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _index = 0;
  final QuestionBloc _questionBloc = QuestionBloc();
  List<Question> _questions = [];


  void _goToNextQuestion() {
    if(_index >= _questions.length-1) return;
    setState(() {
      _index++;
    });
  }

  void _answerQuestion(String userAnswer) {
    if(_questions[_index].correctAnswer != userAnswer) return;
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
          child: FutureBuilder<List<Question>>(
            future: _questionBloc.getQuestions(),
            builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if(snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              _questions = snapshot.data!;
              return Column(
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
              );
            },
          ),
        ),
      ),
    );
  }
}