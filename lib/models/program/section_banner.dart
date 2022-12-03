class SectionBanner {
  final int sectionId;
  final String path;
  final int version;

  SectionBanner(this.sectionId, this.path, this.version);

  factory SectionBanner.fromJson(Map<String, dynamic> json) {
    final int sectionId = json["sectionId"];
    final String path = json["path"];
    final int version = json["version"];

    return SectionBanner(sectionId, path, version);
  }

  Map<String, dynamic> toJson() {
    return {"sectionId": sectionId, "path": path, "version": version};
  }
}
