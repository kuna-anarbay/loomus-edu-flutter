import 'package:loomus_app/models/course/course.dart';
import 'package:loomus_app/models/course/course_progress.dart';
import 'package:loomus_app/models/staff/staff.dart';
import 'package:loomus_app/models/student/student.dart';

class MemberCourse {
  final Course course;
  final String role;
  final String authorName;
  final bool isRequested;
  final bool isDemo;
  CourseProgress? progress;
  final Staff? staff;
  final Student? student;

  MemberCourse(this.course, this.role, this.authorName, this.isRequested,
      this.isDemo, this.progress, this.staff, this.student);

  factory MemberCourse.fromJson(Map<String, dynamic> json) {
    final Course course = Course.fromJson(json["course"]);
    final String role = json["role"];
    final String authorName = json["authorName"];
    final bool isRequested = json["isRequested"];
    final bool isDemo = json["isDemo"];
    final CourseProgress? progress = json["progress"] != null
        ? CourseProgress.fromJson(json["progress"])
        : null;
    final Staff? staff =
        json["staff"] != null ? Staff.fromJson(json["staff"]) : null;
    final Student? student =
        json["student"] != null ? Student.fromJson(json["student"]) : null;

    return MemberCourse(course, role, authorName, isRequested, isDemo, progress,
        staff, student);
  }

  Map<String, dynamic> toJson() {
    return {
      "course": course.toJson(),
      "role": role,
      "authorName": authorName,
      "isRequested": isRequested,
      "isDemo": isDemo,
      "progress": progress?.toJson(),
      "staff": staff?.toJson(),
      "student": student?.toJson()
    };
  }
}
