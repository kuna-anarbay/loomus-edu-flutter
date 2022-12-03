import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/test_repository.dart';
import 'package:loomus_app/models/test/question.dart';
import 'package:loomus_app/models/test/test.dart';
import 'package:loomus_app/models/test/test_submission.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/widgets/test/test_question_option_widget.dart';
import 'package:loomus_app/widgets/test/test_result_widget.dart';

import '../../../models/test/answer.dart';

class TestDataSource {
  final Test test;

  TestDataSource(this.test);
}

mixin TestDelegate {
  void editTestSubmission(TestSubmission submission);
}

class TestViewModel extends BaseViewModel
    with TestQuestionOptionWidgetDelegate, TestResultWidgetDelegate {
  final TestRepository testRepository;
  final Test test;
  final TestDelegate delegate;
  bool isDataLoaded = false;
  bool isSubmitting = false;
  bool isLoading = false;
  TestSubmission? submission;
  List<Question> questions = [];
  List<Answer> answers = [];
  Map<int, List<int>> selectedAnswers = {};

  TestViewModel(TestDataSource dataSource, this.delegate, this.testRepository)
      : test = dataSource.test,
        submission = dataSource.test.submission {
    AnalyticsService.openedPageTest(test.courseId, test.id);
    getQuestions();
  }

  getQuestions() async {
    isLoading = true;
    notifyListeners();
    try {
      questions = await testRepository.getAllQuestions(test.courseId, test.id);
      if (submission != null) {
        answers = (await testRepository.getMySubmission(test.courseId, test.id))
            .answers;
      }
      isDataLoaded = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  submitTest() async {
    if (isSubmitting) return;
    AnalyticsService.pressSubmitTest(test.courseId, test.id);
    isSubmitting = true;
    notifyListeners();

    try {
      final result = await testRepository.submitTest(
          test.courseId, test.id, selectedAnswers);
      selectedAnswers = {};
      answers = result.answers;
      test.submission = result.submission;
      submission = result.submission;
      delegate.editTestSubmission(result.submission);
      isSubmitting = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void selectOption(int questionId, int optionId) {
    if (submission != null) return;
    selectedAnswers[questionId] = [optionId];
    notifyListeners();
  }

  @override
  void resubmitTest() {
    AnalyticsService.pressRetryTest(test.courseId, test.id);
    answers = [];
    test.submission = null;
    submission = null;
    notifyListeners();
  }
}
