class User {
  final int id;
  final String email;
  final String phone;
  String firstName;
  String? lastName;
  int? birthday;
  String? gender;
  String language;
  String color;
  String theme;
  String? avatarUrl;

  String get fullName => "$firstName ${lastName ?? ""}";
  String get languageName => language;

  User(
      this.id,
      this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.birthday,
      this.gender,
      this.language,
      this.color,
      this.theme,
      this.avatarUrl);

  factory User.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String email = json["email"];
    final String phone = json["phone"];
    final String firstName = json["firstName"];
    final String? lastName = json["lastName"];
    final int? birthday = json["birthday"];
    final String? gender = json["gender"];
    final String language = json["language"];
    final String color = json["color"];
    final String theme = json["theme"];
    final String? avatarUrl = json["avatarUrl"];

    return User(id, email, phone, firstName, lastName, birthday, gender,
        language, color, theme, avatarUrl);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "firstName": firstName,
      "lastName": lastName,
      "birthday": birthday,
      "gender": gender,
      "language": language,
      "color": color,
      "theme": theme,
      "avatarUrl": avatarUrl
    };
  }
}
