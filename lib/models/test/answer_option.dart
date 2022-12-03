class AnswerOption {
  final int id;
  final bool isCorrect;

  AnswerOption(this.id, this.isCorrect);

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];

    final bool isCorrect = json["isCorrect"];

    return AnswerOption(id, isCorrect);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "isCorrect": isCorrect};
  }
}
