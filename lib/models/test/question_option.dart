class QuestionOption {
  final int id;
  final int questionId;
  final String value;
  final bool isCorrect;

  QuestionOption(this.id, this.questionId, this.value, this.isCorrect);

  factory QuestionOption.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final int questionId = json["questionId"];
    final String value = json["value"];
    final bool isCorrect = json["isCorrect"];

    return QuestionOption(id, questionId, value, isCorrect);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "questionId": questionId,
      "value": value,
      "isCorrect": isCorrect
    };
  }
}
