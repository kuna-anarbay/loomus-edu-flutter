import 'package:loomus_app/models/program/lesson_video.dart';

import 'lesson_resource.dart';

class Lesson {
  final int id;
  final int courseId;
  final int sectionId;
  final int moduleId;
  final int index;
  final String name;
  final String? description;
  final int duration;
  final String status;
  bool isAvailable;
  bool isPassed;
  final List<LessonVideo> videos;
  final List<LessonResource> resources;

  Lesson(
    this.id,
    this.courseId,
    this.sectionId,
    this.moduleId,
    this.index,
    this.name,
    this.description,
    this.duration,
    this.status,
    this.isAvailable,
    this.isPassed,
    this.videos,
    this.resources,
  );

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final int moduleId = json["moduleId"];
    final int sectionId = json["sectionId"];
    final int index = json["index"];
    final String name = json["name"];
    final String? description = json["description"];
    final int duration = json["duration"];
    final String status = json["status"];
    final bool isAvailable = json["isAvailable"];
    final bool isPassed = json["isPassed"];

    final List<LessonVideo> videos =
        List.from(json["videos"].map((l) => LessonVideo.fromJson(l)));

    final List<LessonResource> resources =
        List.from(json["resources"].map((l) => LessonResource.fromJson(l)));

    return Lesson(id, courseId, sectionId, moduleId, index, name, description,
        duration, status, isAvailable, isPassed, videos, resources);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "sectionId": sectionId,
      "moduleId": moduleId,
      "index": index,
      "name": name,
      "description": description,
      "duration": duration,
      "status": status,
      "isPassed": isPassed,
      "isAvailable": isAvailable,
      "videos": videos.map((e) => e.toJson()).toList(),
      "resources": resources.map((e) => e.toJson()).toList()
    };
  }
}
