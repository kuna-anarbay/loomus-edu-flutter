class HomeworkResource {
  final int homeworkId;
  final int courseId;
  final String path;
  final String name;
  final int size;

  HomeworkResource(
      this.homeworkId, this.courseId, this.name, this.path, this.size);

  factory HomeworkResource.fromJson(Map<String, dynamic> json) {
    final int homeworkId = json["homeworkId"];
    final int courseId = json["courseId"];
    final String name = json["name"];
    final String path = json["path"];
    final int size = json["size"];

    return HomeworkResource(homeworkId, courseId, name, path, size);
  }

  Map<String, dynamic> toJson() {
    return {
      "homeworkId": homeworkId,
      "courseId": courseId,
      "name": name,
      "path": path,
      "size": size
    };
  }
}
