import 'lesson.dart';

enum ModuleStatus { closed, current, passed }

class Module {
  final int id;
  final int courseId;
  final int sectionId;
  final int index;
  final String name;
  final List<Lesson> lessons;

  Module(this.id, this.courseId, this.sectionId, this.index, this.name,
      this.lessons);

  static Module copy(Module module, List<Lesson> lessons) {
    return Module(module.id, module.courseId, module.sectionId, module.index,
        module.name, lessons);
  }

  factory Module.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final int sectionId = json["sectionId"];
    final int index = json["index"];
    final String name = json["name"];
    final List<Lesson> lessons =
        List.from(json["lessons"].map((l) => Lesson.fromJson(l)));

    return Module(id, courseId, sectionId, index, name, lessons);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "sectionId": sectionId,
      "index": index,
      "name": name,
      "lessons": lessons.map((e) => e.toJson()).toList()
    };
  }
}
