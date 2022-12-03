class LessonQuestion {
  final int courseId;
  final int lessonId;
  final int studentId;
  String value;

  LessonQuestion(this.courseId, this.lessonId, this.studentId, this.value);

  factory LessonQuestion.fromJson(Map<String, dynamic> json) {
    final int courseId = json["courseId"];
    final int lessonId = json["lessonId"];
    final int studentId = json["studentId"];
    final String value = json["value"];

    return LessonQuestion(courseId, lessonId, studentId, value);
  }

  Map<String, dynamic> toJson() {
    return {
      "courseId": courseId,
      "lessonId": lessonId,
      "studentId": studentId,
      "value": value
    };
  }
}
