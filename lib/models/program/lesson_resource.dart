import 'package:loomus_app/utilities/utils.dart';

class LessonResource {
  final int id;
  final int courseId;
  final int lessonId;
  final String path;
  final String name;
  final int size;

  String get fileSize => Utils.fileSize(size);

  LessonResource(
      this.id, this.courseId, this.lessonId, this.name, this.path, this.size);

  factory LessonResource.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final int lessonId = json["lessonId"];
    final String name = json["name"];
    final String path = json["path"];
    final int size = json["size"];

    return LessonResource(id, courseId, lessonId, name, path, size);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "lessonId": lessonId,
      "name": name,
      "path": path,
      "size": size
    };
  }
}
