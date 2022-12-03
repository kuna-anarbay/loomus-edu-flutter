import 'package:loomus_app/models/test/answer.dart';
import 'package:loomus_app/models/test/test_submission.dart';

class TestSubmissionDetails {
  final TestSubmission submission;
  final List<Answer> answers;

  TestSubmissionDetails(this.submission, this.answers);

  factory TestSubmissionDetails.fromJson(Map<String, dynamic> json) {
    final TestSubmission submission =
        TestSubmission.fromJson(json["submission"]);
    final List<Answer> answers =
        List.from(json["answers"].map((l) => Answer.fromJson(l)));

    return TestSubmissionDetails(submission, answers);
  }

  Map<String, dynamic> toJson() {
    return {
      "submission": submission.toJson(),
      "answers": answers.map((answer) => answer.toJson())
    };
  }
}
