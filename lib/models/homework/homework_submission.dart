import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../staff/staff.dart';
import 'homework_submission_resource.dart';

class HomeworkSubmission {
  final int homeworkId;
  final int studentId;
  final int courseId;
  final String? value;
  final bool isRepeatable;
  final int triesCount;
  final bool isReviewed;
  final String? notes;
  final int submittedAt;
  final Staff? staff;
  final HomeworkSubmissionResource? resource;

  HomeworkSubmission(
      this.homeworkId,
      this.studentId,
      this.courseId,
      this.value,
      this.isRepeatable,
      this.triesCount,
      this.isReviewed,
      this.notes,
      this.submittedAt,
      this.staff,
      this.resource);

  String statusMessage(AppLocalizations? local) {
    if (!isReviewed) {
      return local?.lessonPageHomeworkPending ?? "";
    }

    return local?.lessonPageHomeworkReviewed ?? "";
  }

  factory HomeworkSubmission.fromJson(Map<String, dynamic> json) {
    final int homeworkId = json["homeworkId"];
    final int studentId = json["studentId"];
    final int courseId = json["courseId"];
    final String value = json["value"];
    final bool isRepeatable = json["isRepeatable"];
    final int triesCount = json["triesCount"];
    final bool isReviewed = json["isReviewed"];
    final String? notes = json["notes"];
    final int submittedAt = json["submittedAt"];
    final Staff? staff =
        json["staff"] != null ? Staff.fromJson(json["staff"]) : null;
    final HomeworkSubmissionResource? resource = json["resource"] != null
        ? HomeworkSubmissionResource.fromJson(json["resource"])
        : null;

    return HomeworkSubmission(homeworkId, studentId, courseId, value,
        isRepeatable, triesCount, isReviewed, notes, submittedAt, staff, resource);
  }

  Map<String, dynamic> toJson() {
    return {
      "homeworkId": homeworkId,
      "studentId": studentId,
      "courseId": courseId,
      "value": value,
      "isRepeatable": isRepeatable,
      "triesCount": triesCount,
      "isReviewed": isReviewed,
      "notes": notes,
      "submittedAt": submittedAt,
      "staff": staff?.toJson(),
      "resource": resource?.toJson()
    };
  }
}
