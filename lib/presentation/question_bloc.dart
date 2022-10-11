import 'package:quiz/data/response/question_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:quiz/domain/entity/question_entity.dart';

class QuestionBloc {

  List<QuestionEntity> _questions = List.empty();

  Future<List<QuestionEntity>> getQuestions() async {
    if(_questions.isNotEmpty) return _questions;
    _questions = await _retrieveQuestions();
    return _questions;
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
}

