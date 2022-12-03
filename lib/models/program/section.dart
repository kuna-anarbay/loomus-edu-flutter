import 'package:loomus_app/models/program/module.dart';
import 'package:loomus_app/models/program/section_banner.dart';

class Section {
  final int id;
  final int courseId;
  final int index;
  final String name;
  final String? description;
  final SectionBanner? banner;
  final List<Module> modules;

  Section(this.id, this.courseId, this.index, this.name, this.description,
      this.banner, this.modules);

  static Section copy(Section section, List<Module> modules) {
    return Section(section.id, section.courseId, section.index, section.name,
        section.description, section.banner, modules);
  }

  factory Section.fromJson(Map<String, dynamic> jsonMap) {
    final int id = jsonMap["id"];
    final int courseId = jsonMap["courseId"];
    final int index = jsonMap["index"];
    final String name = jsonMap["name"];
    final String? description = jsonMap["description"];
    final SectionBanner? banner = jsonMap["banner"] != null
        ? SectionBanner.fromJson(jsonMap["banner"])
        : null;
    final List<Module> modules =
        List.from(jsonMap["modules"].map((l) => Module.fromJson(l)));

    return Section(id, courseId, index, name, description, banner, modules);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "index": index,
      "name": name,
      "description": description,
      "modules": modules.map((e) => e.toJson()).toList()
    };
  }
}
