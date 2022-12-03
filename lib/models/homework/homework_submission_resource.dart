class HomeworkSubmissionResource {
  final int homeworkId;
  final int studentId;
  final int courseId;
  final String path;
  final String name;
  final int size;

  HomeworkSubmissionResource(this.homeworkId, this.studentId, this.courseId,
      this.name, this.path, this.size);

  factory HomeworkSubmissionResource.fromJson(Map<String, dynamic> json) {
    final int homeworkId = json["homeworkId"];
    final int studentId = json["studentId"];
    final int courseId = json["courseId"];
    final String name = json["name"];
    final String path = json["path"];
    final int size = json["size"];

    return HomeworkSubmissionResource(
        homeworkId, studentId, courseId, name, path, size);
  }

  Map<String, dynamic> toJson() {
    return {
      "homeworkId": homeworkId,
      "studentId": studentId,
      "courseId": courseId,
      "name": name,
      "path": path,
      "size": size
    };
  }
}
