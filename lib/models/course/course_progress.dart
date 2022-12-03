class CourseProgress {
  final int count;
  final int total;

  CourseProgress(this.count, this.total);

  factory CourseProgress.fromJson(Map<String, dynamic> json) {
    final int count = json["count"];
    final int total = json["total"];

    return CourseProgress(count, total);
  }

  Map<String, dynamic> toJson() {
    return {"count": count, "total": total};
  }
}