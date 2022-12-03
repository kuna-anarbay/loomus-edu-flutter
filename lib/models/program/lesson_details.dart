import 'package:loomus_app/models/homework/homework.dart';
import 'package:loomus_app/models/program/lesson_question.dart';
import 'package:loomus_app/models/test/test.dart';

import 'lesson.dart';

class LessonDetails {
  final Lesson lesson;
  Test? test;
  Homework? homework;
  final LessonQuestion? question;
  int? rating;
  final bool canAskQuestion;

  LessonDetails(this.lesson, this.test, this.homework, this.question,
      this.rating, this.canAskQuestion);

  factory LessonDetails.fromJson(Map<String, dynamic> json) {
    final Lesson lesson = Lesson.fromJson(json["lesson"]);
    final Test? test =
        json["test"] != null ? Test.fromJson(json["test"]) : null;
    final Homework? homework =
        json["homework"] != null ? Homework.fromJson(json["homework"]) : null;
    final LessonQuestion? question = json["question"] != null
        ? LessonQuestion.fromJson(json["question"])
        : null;
    final int? rating = json["rating"];
    final bool canAskQuestion = json["canAskQuestion"];

    return LessonDetails(
        lesson, test, homework, question, rating, canAskQuestion);
  }

  Map<String, dynamic> toJson() {
    return {
      "lesson": lesson.toJson(),
      "test": test?.toJson(),
      "homework": homework?.toJson(),
      "question": question?.toJson(),
      "rating": rating,
      "canAskQuestion": canAskQuestion
    };
  }
}
