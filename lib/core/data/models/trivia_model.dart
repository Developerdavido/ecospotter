import 'package:citizen_app/core/data/models/question_model.dart';
import 'package:citizen_app/core/entity/trivia_entity.dart';

class TriviaModel extends TriviaEntity {
  TriviaModel({required super.questions});

  factory TriviaModel.fromJson(Map<String, dynamic> json) {
    return TriviaModel(
      questions: json["questions"] == null
          ? []
          : List<QuestionModel>.from(
              json["questions"]!.map((x) => QuestionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
