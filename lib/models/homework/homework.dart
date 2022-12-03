import 'package:loomus_app/models/homework/homework_submission.dart';

import 'homework_resource.dart';

class Homework {
  final int id;
  final int courseId;
  final String value;
  final String? solutionVideoUrl;
  final HomeworkResource? resource;
  HomeworkSubmission? submission;

  bool get isPassed => submission != null;

  Homework(this.id, this.courseId, this.value, this.solutionVideoUrl,
      this.resource, this.submission);

  factory Homework.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final String value = json["value"];
    final String? solutionVideoUrl = json["solutionVideoUrl"];

    final HomeworkResource? resource = json["resource"] != null
        ? HomeworkResource.fromJson(json["resource"])
        : null;
    final HomeworkSubmission? submission = json["submission"] != null
        ? HomeworkSubmission.fromJson(json["submission"])
        : null;

    return Homework(
        id, courseId, value, solutionVideoUrl, resource, submission);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "value": value,
      "solutionVideoUrl": solutionVideoUrl,
      "resource": resource?.toJson(),
      "submission": submission?.toJson()
    };
  }
}
