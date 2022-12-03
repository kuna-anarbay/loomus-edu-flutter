class Student {
  final int id;
  final bool testAgreementHidden;
  final bool homeworkAgreementHidden;
  final bool homeworkAvailable;
  final bool questionAvailable;

  Student(this.id, this.testAgreementHidden, this.homeworkAgreementHidden,
      this.homeworkAvailable, this.questionAvailable);

  factory Student.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final bool testAgreementHidden = json["testAgreementHidden"];
    final bool homeworkAgreementHidden = json["homeworkAgreementHidden"];
    final bool homeworkAvailable = json["homeworkAvailable"];
    final bool questionAvailable = json["questionAvailable"];

    return Student(id, testAgreementHidden, homeworkAgreementHidden,
        homeworkAvailable, questionAvailable);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "testAgreementHidden": testAgreementHidden,
      "homeworkAgreementHidden": homeworkAgreementHidden,
      "homeworkAvailable": homeworkAvailable,
      "questionAvailable": questionAvailable
    };
  }
}
