class TestSubmission {
  final int testId;
  final int studentId;
  final int courseId;
  final int triesCount;
  final int score;
  final int total;
  final bool isReviewable;
  final int submittedAt;

  TestSubmission(this.testId, this.studentId, this.courseId, this.triesCount,
      this.score, this.total, this.isReviewable, this.submittedAt);

  factory TestSubmission.fromJson(Map<String, dynamic> json) {
    final int testId = json["testId"];
    final int studentId = json["studentId"];
    final int courseId = json["courseId"];
    final int triesCount = json["triesCount"];
    final int score = json["score"];
    final int total = json["total"];
    final bool isReviewable = json["isReviewable"];
    final int submittedAt = json["submittedAt"];

    return TestSubmission(testId, studentId, courseId, triesCount, score, total,
        isReviewable, submittedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      "testId": testId,
      "studentId": studentId,
      "courseId": courseId,
      "triesCount": triesCount,
      "score": score,
      "total": total,
      "isReviewable": isReviewable,
      "submittedAt": submittedAt
    };
  }
}
