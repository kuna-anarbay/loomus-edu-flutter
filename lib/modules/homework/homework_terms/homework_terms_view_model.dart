import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/course_repository.dart';
import 'package:loomus_app/models/homework/homework.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';

class HomeworkTermsDataSource {
  final Homework homework;
  final bool isHomeworkAvailable;

  HomeworkTermsDataSource(this.homework, this.isHomeworkAvailable);
}

class HomeworkTermsViewModel extends BaseViewModel {
  final CourseRepository courseRepository;
  final Homework homework;
  final HomeworkDelegate delegate;
  bool isAgreementHidden = false;
  bool isHomeworkAvailable;

  HomeworkTermsViewModel(
      HomeworkTermsDataSource dataSource, this.delegate, this.courseRepository)
      : homework = dataSource.homework,
        isHomeworkAvailable = dataSource.isHomeworkAvailable {
    AnalyticsService.openedPageHomeworkTerms(homework.courseId, homework.id);
  }

  toggleAgreementHidden() {
    isAgreementHidden = !isAgreementHidden;
    AnalyticsService.pressDontShowHomeworkInstructions(homework.courseId, homework.id, isAgreementHidden);
    notifyListeners();
  }

  onHideHomework() {
    if (!isAgreementHidden) return;
    try {
      courseRepository.setHomeworkAgreementHidden(homework.courseId);
    } catch (e) {}
  }
}
