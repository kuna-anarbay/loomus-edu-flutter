import 'package:loomus_app/models/test/test_submission.dart';

class Test {
  final int id;
  final int courseId;
  final int passingGrade;
  TestSubmission? submission;

  bool get isPassed => submission?.isReviewable ?? false;

  Test(this.id, this.courseId, this.passingGrade, this.submission);

  factory Test.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final int passingGrade = json["passingGrade"];
    final TestSubmission? submission = json["submission"] != null
        ? TestSubmission.fromJson(json["submission"])
        : null;

    return Test(id, courseId, passingGrade, submission);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "passingGrade": passingGrade,
      "submission": submission?.toJson()
    };
  }
}
