
import 'package:quiz/domain/entity/question_entity.dart';

class QuestionPageState {
  final QuestionEntity currentQuestion;
  final int questionsCount;
  final int questionIndex;
  final bool hasBeenAnswered;

  QuestionPageState({
    required this.currentQuestion,
    required this.questionsCount,
    required this.questionIndex,
    this.hasBeenAnswered = false
  });
}