class CourseBanner {
  final int courseId;
  final String path;
  final int version;

  CourseBanner(this.courseId, this.path, this.version);

  factory CourseBanner.fromJson(Map<String, dynamic> json) {
    final int courseId = json["courseId"];
    final String path = json["path"];
    final int version = json["version"];

    return CourseBanner(courseId, path, version);
  }

  Map<String, dynamic> toJson() {
    return {"courseId": courseId, "path": path, "version": version};
  }
}
