import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/models/course/course_progress.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/models/user/user.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/services/notifications_service.dart';

import '../../data/repository/course_repository.dart';

class HomeDataSource {
  final User user;

  HomeDataSource(this.user);
}

class HomeViewModel extends BaseViewModel with CourseDelegate {
  final CourseRepository courseRepository;
  final NotificationsService notificationsService;
  final User user;
  bool isLoading = false;
  List<MemberCourse> courses = [];

  HomeViewModel(HomeDataSource dataSource, this.notificationsService,
      this.courseRepository)
      : user = dataSource.user {
    AnalyticsService.openedPageHome();
    notificationsService.registerNotification();
    onGetCourses();
  }

  onGetCourses() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      courses = await courseRepository.getMyCourses();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void updateCourseProgress(int courseId, CourseProgress progress) {
    final index = courses.indexWhere((c) => c.course.id == courseId);
    if (index == -1) return;
    courses[index].progress = progress;
    notifyListeners();
  }
}
