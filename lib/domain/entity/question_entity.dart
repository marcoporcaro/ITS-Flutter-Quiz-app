
import 'package:quiz/data/response/question_response.dart';

class QuestionEntity {

  String? text;
  List<String>? answers;
  String? correctAnswer;

  QuestionEntity({required this.text, required this.answers, required this.correctAnswer});
}


extension QuestionMapper on QuestionResponse {

  List<QuestionEntity> toEntity() {
    return results?.map((e) {
      var answers = e.incorrectAnswers ?? List.empty();
      answers.add(e.correctAnswer ?? "");
      answers.shuffle();
      return QuestionEntity(
          text: e.question?.replaceAll("&#039;", "\"").replaceAll("&quot;", "\""),
          correctAnswer: e.correctAnswer,
          answers: answers
      );
    }).toList() ?? List.empty();
  }
}