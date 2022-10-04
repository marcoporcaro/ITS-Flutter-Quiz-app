
import 'package:quiz/question.dart';

class QuestionBloc {

  List<Question>? _questions;

  Future<List<Question>> getQuestions() async {
    if(_questions != null) {
      return Future.value(_questions);
    }
    else {
      _questions = await _fetchQuestions();
      return _questions!;
    }
  }


  //FAKE API CALL
  Future<List<Question>> _fetchQuestions() {
    return Future.delayed(const Duration(seconds: 3), () => [
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
    ]
    );
  }

}