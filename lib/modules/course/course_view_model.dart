import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/course_repository.dart';
import 'package:loomus_app/data/repository/lesson_repository.dart';
import 'package:loomus_app/models/course/course_progress.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/models/program/lesson.dart';
import 'package:loomus_app/models/program/module.dart';
import 'package:loomus_app/models/program/section.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/widgets/lesson/lesson_widget.dart';
import 'package:loomus_app/widgets/module/module_widget.dart';
import 'package:loomus_app/widgets/section/section_widget.dart';

class CourseDataSource {
  final MemberCourse memberCourse;
  final bool isDemoView;

  CourseDataSource(this.memberCourse, this.isDemoView);
}

mixin CourseDelegate {
  void updateCourseProgress(int courseId, CourseProgress progress);
}

class CourseViewModel extends BaseViewModel
    with
        LessonWidgetDelegate,
        LessonDelegate,
        ModuleWidgetDelegate,
        SectionWidgetDelegate {
  final LessonRepository lessonRepository;
  final CourseRepository courseRepository;
  final MemberCourse memberCourse;
  final CourseDelegate delegate;
  final bool isDemoView;
  List<Lesson> allLessons = [];
  bool isLoading = false;
  List<Section> sections = [];

  CourseViewModel(CourseDataSource dataSource, this.delegate,
      this.lessonRepository, this.courseRepository)
      : memberCourse = dataSource.memberCourse,
        isDemoView = dataSource.isDemoView {
    AnalyticsService.openedPageCourse(memberCourse.course.id);
    onGetSections();
  }

  Lesson? currentLesson() {
    if (isDemoView) return null;
    Lesson? temp;
    sections.descendingBy((e) => e.index).forEach((section) {
      section.modules.descendingBy((e) => e.index).forEach((module) {
        module.lessons.descendingBy((e) => e.index).forEach((lesson) {
          if (!lesson.isPassed && lesson.isAvailable && lesson.status == "ACTIVE") {
            temp = lesson;
          }
        });
      });
    });

    return temp;
  }

  @override
  bool isLessonAvailable(Lesson lesson) {
    if (memberCourse.role != "STUDENT") return true;
    if (isDemoView) return false;
    if (lesson.status != "ACTIVE") return false;
    if (lesson.isPassed) return true;

    final sectionIndex =
        sections.indexWhere((element) => element.id == lesson.sectionId);
    if (sectionIndex == -1) return false;
    final moduleIndex = sections[sectionIndex]
        .modules
        .indexWhere((element) => element.id == lesson.moduleId);
    if (moduleIndex == -1) return false;

    final lessonIndex = sections[sectionIndex]
        .modules[moduleIndex]
        .lessons
        .indexWhere((element) => element.id == lesson.id);

    if (lessonIndex == -1) return false;

    if (lessonIndex != 0) {
      return sections[sectionIndex]
          .modules[moduleIndex]
          .lessons[lessonIndex - 1]
          .isPassed;
    }

    if (moduleIndex != 0) {
      if (sections[sectionIndex].modules[moduleIndex - 1].lessons.isEmpty) {
        return false;
      }

      return sections[sectionIndex]
          .modules[moduleIndex - 1]
          .lessons
          .last
          .isPassed;
    }

    if (sectionIndex != 0) {
      if (sections[sectionIndex - 1].modules.isEmpty) {
        return false;
      }

      if (sections[sectionIndex - 1].modules.last.lessons.isEmpty) {
        return false;
      }

      return sections[sectionIndex - 1].modules.last.lessons.last.isPassed;
    }

    return true;
  }

  onGetSections() async {
    isLoading = true;
    notifyListeners();
    try {
      final tempSections = isDemoView
          ? await lessonRepository.getVisibleLessons(memberCourse.course.id)
          : await lessonRepository.getAllSections(memberCourse.course.id);
      sections = tempSections.ascendingBy((e) => e.index).map((section) {
        final tempModules =
            section.modules.ascendingBy((e) => e.index).map((module) {
          final tempLessons =
              module.lessons.ascendingBy((e) => e.index).toList();
          return Module.copy(module, tempLessons);
        }).toList();

        return Section.copy(section, tempModules);
      }).toList();

      allLessons = [];
      for (var section in sections) {
        for (var module in section.modules) {
          allLessons.addAll(module.lessons);
        }
      }
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
    if (isDemoView) return;
    if (memberCourse.student == null) return;
    try {
      courseRepository.setOpened(memberCourse.course.id);
    } catch (e) {}
  }

  @override
  void setLessonPassed(Lesson lesson) {
    if (isDemoView) return;
    final sectionIndex =
        sections.indexWhere((element) => element.id == lesson.sectionId);
    if (sectionIndex == -1) return;
    final moduleIndex = sections[sectionIndex]
        .modules
        .indexWhere((element) => element.id == lesson.moduleId);
    if (moduleIndex == -1) return;

    final lessonIndex = sections[sectionIndex]
        .modules[moduleIndex]
        .lessons
        .indexWhere((element) => element.id == lesson.id);
    if (lessonIndex == -1) return;
    if (sections[sectionIndex]
        .modules[moduleIndex]
        .lessons[lessonIndex]
        .isPassed) return;
    sections[sectionIndex].modules[moduleIndex].lessons[lessonIndex].isPassed =
        true;
    final progress = memberCourse.progress;
    if (progress != null) {
      delegate.updateCourseProgress(memberCourse.course.id,
          CourseProgress(progress.count + 1, progress.total));
    }

    notifyListeners();
  }

  @override
  ModuleStatus getModuleStatus(Module module) {
    if (module.lessons.where((element) => !element.isPassed).isEmpty) {
      return ModuleStatus.passed;
    }

    if (module.lessons.where((element) => element.isPassed).isNotEmpty) {
      return ModuleStatus.current;
    }

    final sectionIndex =
        sections.indexWhere((element) => element.id == module.sectionId);
    if (sectionIndex == -1) return ModuleStatus.current;
    final moduleIndex = sections[sectionIndex]
        .modules
        .indexWhere((element) => element.id == module.id);
    if (moduleIndex == -1) return ModuleStatus.current;
    if (moduleIndex != 0) {
      if (sections[sectionIndex]
          .modules[moduleIndex - 1]
          .lessons
          .where((element) => !element.isPassed)
          .isEmpty) {
        return ModuleStatus.current;
      } else {
        return ModuleStatus.closed;
      }
    }

    if (sectionIndex == 0) return ModuleStatus.current;

    if (sections[sectionIndex - 1].modules.isEmpty) return ModuleStatus.current;

    if (sections[sectionIndex - 1]
        .modules
        .last
        .lessons
        .where((element) => !element.isPassed)
        .isEmpty) {
      return ModuleStatus.current;
    } else {
      return ModuleStatus.closed;
    }
  }

  @override
  bool isSectionPassed(Section section) {
    return allLessons
        .where(
            (element) => element.sectionId == section.id && !element.isPassed)
        .isEmpty;
  }
}
