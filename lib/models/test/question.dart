import 'package:loomus_app/models/test/question_option.dart';

class Question {
  final int id;
  final int testId;
  final String value;
  final String? solution;
  final List<QuestionOption> options;

  Question(this.id, this.testId, this.value, this.solution, this.options);

  factory Question.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int testId = json["testId"];
    final String value = json["value"];
    final String? solution = json["solution"];
    final List<QuestionOption> options =
        List.from(json["options"].map((l) => QuestionOption.fromJson(l)));

    return Question(id, testId, value, solution, options);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "testId": testId,
      "value": value,
      "solution": solution,
      "options": options.map((option) => option.toJson())
    };
  }
}
