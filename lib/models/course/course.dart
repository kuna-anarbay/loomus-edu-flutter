import 'course_banner.dart';

class Course {
  final int id;
  final String name;
  final bool isFeatured;
  final String? description;
  final CourseBanner? banner;

  Course(this.id, this.name, this.isFeatured, this.description, this.banner);

  factory Course.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String name = json["name"];
    final String? description = json["description"];
    final bool isFeatured = json["isFeatured"];
    final CourseBanner? banner =
        json["banner"] != null ? CourseBanner.fromJson(json["banner"]) : null;

    return Course(id, name, isFeatured, description, banner);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "isFeatured": isFeatured,
      "description": description,
      "banner": banner?.toJson()
    };
  }
}
