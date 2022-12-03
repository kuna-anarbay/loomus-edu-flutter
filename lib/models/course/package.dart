class Package {
  final int id;
  final int courseId;
  final String name;
  final bool homeworkAvailable;
  final bool questionAvailable;

  Package(this.id, this.courseId, this.name, this.homeworkAvailable,
      this.questionAvailable);

  factory Package.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final String name = json["name"];
    final bool homeworkAvailable = json["homeworkAvailable"];
    final bool questionAvailable = json["questionAvailable"];

    return Package(id, courseId, name, homeworkAvailable, questionAvailable);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "name": name,
      "homeworkAvailable": homeworkAvailable,
      "questionAvailable": questionAvailable
    };
  }
}
