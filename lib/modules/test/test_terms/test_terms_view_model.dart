import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/course_repository.dart';
import 'package:loomus_app/models/test/test.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';

class TestTermsDataSource {
  final Test test;

  TestTermsDataSource(this.test);
}

class TestTermsViewModel extends BaseViewModel {
  final CourseRepository courseRepository;
  final Test test;
  final TestDelegate delegate;
  bool isAgreementHidden = false;

  TestTermsViewModel(
      TestTermsDataSource dataSource, this.delegate, this.courseRepository)
      : test = dataSource.test {
    AnalyticsService.openedPageTestTerms(test.courseId, test.id);
  }

  toggleAgreementHidden() {
    isAgreementHidden = !isAgreementHidden;
    AnalyticsService.pressDontShowTestInstructions(
        test.courseId, test.id, isAgreementHidden);
    notifyListeners();
  }

  onHideTest() {
    if (!isAgreementHidden) return;
    try {
      courseRepository.setTestAgreementHidden(test.courseId);
    } catch (e) {}
  }
}
