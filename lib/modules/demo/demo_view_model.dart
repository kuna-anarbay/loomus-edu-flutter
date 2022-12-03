import 'package:collection/collection.dart';
import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/course_repository.dart';
import 'package:loomus_app/data/repository/lesson_repository.dart';
import 'package:loomus_app/models/course/course_progress.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/models/program/lesson.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/widgets/lesson/demo_lesson_widget.dart';

class DemoDataSource {
  final MemberCourse memberCourse;

  DemoDataSource(this.memberCourse);
}

class DemoViewModel extends BaseViewModel
    with DemoLessonWidgetDelegate, LessonDelegate, CourseDelegate {
  final LessonRepository lessonRepository;
  final CourseRepository courseRepository;
  final MemberCourse memberCourse;
  bool isLoading = false;
  List<Lesson> lessons = [];

  DemoViewModel(
      DemoDataSource dataSource, this.lessonRepository, this.courseRepository)
      : memberCourse = dataSource.memberCourse {
    AnalyticsService.openedPageDemo(memberCourse.course.id);
    onGetSections();
  }

  @override
  bool isLessonAvailable(Lesson lesson) {
    if (lesson.status != "ACTIVE") return false;
    return true;
  }

  onGetSections() async {
    isLoading = true;
    notifyListeners();
    try {
      final tempSections =
          await lessonRepository.getAllSections(memberCourse.course.id);
      lessons = tempSections.firstOrNull?.modules.firstOrNull?.lessons
              .ascendingBy((e) => e.index)
              .toList() ??
          [];
      onSetOpened();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  onSetOpened() {
    if (memberCourse.student == null) return;
    try {
      courseRepository.setOpened(memberCourse.course.id);
    } catch (e) {}
  }

  @override
  void setLessonPassed(Lesson lesson) {
    final lessonIndex =
        lessons.indexWhere((element) => element.id == lesson.id);
    if (lessonIndex == -1) return;
    lessons[lessonIndex].isPassed = true;
    notifyListeners();
  }

  @override
  void updateCourseProgress(int courseId, CourseProgress progress) {}

  @override
  void dispose() {
    super.dispose();
  }
}
