import 'dart:async';

import 'package:quiz/data/response/question_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:quiz/domain/entity/question_entity.dart';
import 'package:quiz/presentation/question/question_page_state.dart';

class QuestionBloc {

  StreamController<QuestionPageState> pageState = StreamController.broadcast();
  StreamController<int> timer = StreamController.broadcast();

  List<QuestionEntity> _questions = List.empty();
  int _index = 0;

  getQuestions() async {
    if(_questions.isEmpty) {
      _questions = await _retrieveQuestions();
    }
    pageState.add(
        QuestionPageState(
            currentQuestion: _questions[_index],
            questionsCount: _questions.length,
            questionIndex: _index+1)
    );
    _startTimer();
  }

  void answerQuestion(String userAnswer) async {
    pageState.add(
        QuestionPageState(
            currentQuestion: _questions[_index],
            questionsCount: _questions.length,
            questionIndex: _index+1,
            hasBeenAnswered: true
        )
    );
  }


  void _goToNextQuestion() {
    if(_index >= _questions.length-1) return;
    _index++;
    pageState.add(
        QuestionPageState(
            currentQuestion: _questions[_index],
            questionsCount: _questions.length,
            questionIndex: _index+1)
    );
    _startTimer();
  }

  _startTimer() {
    Stream.periodic(const Duration(seconds: 1), (count) {
      timer.add(10 - count);
    })
        .take(11)
    .listen((event) { }, onDone: () => _goToNextQuestion());
  }

  Future<List<QuestionEntity>> _retrieveQuestions() async {

    var url = Uri.parse("https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple");
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var responseMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
        var questionResponse = QuestionResponse.fromJson(responseMap);
        return questionResponse.toEntity();
      }
    }
    catch(e) {
      print(e);
    }

    return List.empty();
  }

  dispose() {
    pageState.close();
  }
}

