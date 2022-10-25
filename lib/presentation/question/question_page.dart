import 'package:flutter/material.dart';
import 'package:quiz/presentation/question/answer_button.dart';
import 'package:quiz/presentation/question/question_bloc.dart';
import 'package:quiz/presentation/question/question_page_state.dart';
import 'package:quiz/presentation/style/colors.dart';


class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.title, required this.category}) : super(key: key);

  final String title;
  final int category;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuestionBloc _questionBloc;

  @override
  void initState() {
    _questionBloc = QuestionBloc(category: widget.category);
    _questionBloc.getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [backgroundTopColor, backgroundBottomColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                StreamBuilder<int>(
                    stream: _questionBloc.timer.stream,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if(snapshot.data != null) {
                        return Text("${snapshot.data}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24
                          ),);
                      } else {
                        return const Text("");
                      }
                    }
                ),
                Expanded(
                  child: StreamBuilder<QuestionPageState>(
                    stream: _questionBloc.pageState.stream,
                    builder: (BuildContext context, AsyncSnapshot<QuestionPageState> snapshot) {
                      if(snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var currentQuestion = snapshot.data!.currentQuestion;
                      var questionIndex = snapshot.data!.questionIndex;
                      var questionsCount = snapshot.data!.questionsCount;
                      var hasBeenAnswered = snapshot.data!.hasBeenAnswered;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Center(
                                child: Image.asset("assets/images/quiz_image.png",
                            scale: 0.5,
                          ),
                              )),
                          Text("question $questionIndex of $questionsCount",
                            style: const TextStyle(
                              fontSize: 18,
                              color: questionIndexColor,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Text(currentQuestion.text!,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: questionColor,
                            ),
                          ),
                          const SizedBox(height: 50,),
                          AbsorbPointer(
                            absorbing: hasBeenAnswered,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: currentQuestion.answers!.map((answer) {
                                var answerState = AnswerState.none;
                                if(hasBeenAnswered) {
                                  if(answer == currentQuestion.correctAnswer) {
                                    answerState = AnswerState.correct;
                                  }
                                  else {
                                    answerState = AnswerState.wrong;
                                  }
                                }
                                return AnswerButton(
                                  answer: answer,
                                  answerState: answerState,
                                  onPressed: () => _questionBloc.answerQuestion(answer),
                                );
                              }
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionBloc.dispose();
    super.dispose();
  }
}