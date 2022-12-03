class Staff {
  final int id;
  final int courseId;
  final String firstName;
  final String? lastName;
  final String email;
  final String role;
  final String? avatarUrl;

  String get fullName => "$firstName ${lastName ?? ""}";

  Staff(this.id, this.courseId, this.firstName, this.lastName, this.email,
      this.role, this.avatarUrl);

  factory Staff.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int courseId = json["courseId"];
    final String firstName = json["firstName"];
    final String? lastName = json["lastName"];
    final String email = json["email"];
    final String role = json["role"];
    final String? avatarUrl = json["avatarUrl"];

    return Staff(id, courseId, firstName, lastName, email, role, avatarUrl);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "courseId": courseId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "role": role,
      "avatarUrl": avatarUrl
    };
  }
}
