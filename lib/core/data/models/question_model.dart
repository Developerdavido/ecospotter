
import 'package:citizen_app/core/entity/question_entity.dart';

class QuestionModel extends QuestionEntity {

  QuestionModel({
    required super.topic,
    required super.subject,
    required super.question,
    required super.answers,
});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    subject: json["subject"],
    question: json["question"],
    topic: json["topic"],
    answers: json["answers"] == null ? [] : List<String>.from(json["answers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "question": question,
    "topic": topic,
    "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
  };
}