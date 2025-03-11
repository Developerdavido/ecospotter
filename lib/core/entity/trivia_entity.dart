

import 'package:citizen_app/core/entity/question_entity.dart';

import '../data/models/question_model.dart';

class TriviaEntity {

  final List<QuestionModel> questions;

  const TriviaEntity({
    required this.questions,
  });
}