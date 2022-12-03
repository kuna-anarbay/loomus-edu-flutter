import 'package:loomus_app/models/test/answer_option.dart';

class Answer {
  final int questionId;
  final int studentId;
  final int courseId;
  final List<AnswerOption> options;

  Answer(this.questionId, this.studentId, this.courseId, this.options);

  factory Answer.fromJson(Map<String, dynamic> json) {
    final int questionId = json["questionId"];
    final int studentId = json["studentId"];
    final int courseId = json["courseId"];
    final List<AnswerOption> options =
        List.from(json["options"].map((e) => AnswerOption.fromJson(e)));

    return Answer(questionId, studentId, courseId, options);
  }

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "studentId": studentId,
      "courseId": courseId,
      "optionIds": options.map((e) => e.toJson()).toList()
    };
  }
}
