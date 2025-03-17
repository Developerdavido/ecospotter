
import 'package:citizen_app/core/entity/question_entity.dart';

class QuestionModel extends QuestionEntity {

  QuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.answers,
});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    correctAnswer: json["correctAnswer"],
    question: json["question"],
    answers: json["answers"] == null ? [] : List<String>.from(json["answers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "correctAnswer": correctAnswer,
    "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
  };
}