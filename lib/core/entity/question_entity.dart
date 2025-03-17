

class QuestionEntity {


  final String? correctAnswer;
  final String? question;
  final List<String>? answers;

  const QuestionEntity({
    this.correctAnswer,
    this.question,
    this.answers,
  });
}