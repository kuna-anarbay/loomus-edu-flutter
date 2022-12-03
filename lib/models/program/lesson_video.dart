import 'package:loomus_app/utilities/utils.dart';

class LessonVideo {
  final int courseId;
  final int lessonId;
  final String path;
  final int quality;

  LessonVideo(
      this.courseId, this.lessonId, this.path, this.quality);

  factory LessonVideo.fromJson(Map<String, dynamic> json) {
    final int courseId = json["courseId"];
    final int lessonId = json["lessonId"];
    final String path = json["path"];
    final int quality = json["quality"];

    return LessonVideo(courseId, lessonId,  path, quality);
  }

  Map<String, dynamic> toJson() {
    return {
      "courseId": courseId,
      "lessonId": lessonId,
      "path": path,
      "quality": quality
    };
  }
}
