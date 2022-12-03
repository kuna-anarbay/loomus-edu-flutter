import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/homework_repository.dart';
import 'package:loomus_app/data/repository/lesson_repository.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/models/homework/homework_resource.dart';
import 'package:loomus_app/models/homework/homework_submission.dart';
import 'package:loomus_app/models/program/lesson.dart';
import 'package:loomus_app/models/program/lesson_details.dart';
import 'package:loomus_app/models/program/module.dart';
import 'package:loomus_app/models/test/test_submission.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/widgets/homework/homework_widget.dart';
import 'package:loomus_app/widgets/lesson_question/lesson_question_widget.dart';
import 'package:loomus_app/widgets/lesson_resource/lesson_resource_widget.dart';
import 'package:loomus_app/widgets/lesson_review/lesson_review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/pod_player/src/controllers/pod_player_controller.dart';
import '../../features/pod_player/src/models/play_video_from.dart';
import '../../features/pod_player/src/models/pod_player_config.dart';
import '../../features/pod_player/src/models/vimeo_models.dart';
import '../../models/program/lesson_resource.dart';
import '../../widgets/homework/homework_resource_widget.dart';

class LessonDataSource {
  final MemberCourse memberCourse;
  final Lesson lesson;

  LessonDataSource(this.memberCourse, this.lesson);
}

mixin LessonDelegate {
  void setLessonPassed(Lesson lesson);
}

mixin LessonVideoDelegate {
  void pauseVideo();
}

class LessonViewModel extends BaseViewModel
    with
        LessonReviewWidgetDelegate,
        TestDelegate,
        HomeworkWidgetDelegate,
        LessonQuestionWidgetDelegate,
        LessonResourceWidgetDelegate,
        HomeworkResourceWidgetDelegate,
        LessonVideoDelegate {
  // final YoutubePlayerController youtubePlayerController;
  final PodPlayerController controller;
  final LessonRepository lessonRepository;
  final HomeworkRepository homeworkRepository;
  final List<Module> modules = [];
  final Lesson lesson;
  final MemberCourse memberCourse;
  final LessonDelegate delegate;
  List<int> loadingResources = [];
  bool isDownloadingHomeworkResource = false;
  bool isLoading = false;
  String question = "";
  LessonDetails? lessonDetails;
  double offset = 0.0;

  LessonViewModel(LessonDataSource dataSource, this.delegate,
      this.lessonRepository, this.homeworkRepository)
      : lesson = dataSource.lesson,
        memberCourse = dataSource.memberCourse,
        controller = PodPlayerController(
            playVideoFrom: PlayVideoFrom.networkQualityUrls(
                videoUrls: dataSource.lesson.videos
                    .map((video) => VideoQualityUrl(
                        quality: video.quality, url: video.path))
                    .toList()),
            podPlayerConfig: const PodPlayerConfig(autoPlay: false)) {
    AnalyticsService.openedPageLesson(lesson.courseId, lesson.id);
    controller.initialise();
    getLessonDetails();
  }

  getLessonDetails() async {
    isLoading = true;
    notifyListeners();
    try {
      lessonDetails =
          await lessonRepository.getLesson(lesson.courseId, lesson.id);
      if (lessonDetails?.test == null && lessonDetails?.homework == null) {
        delegate.setLessonPassed(lesson);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  rateLesson(int rating) async {
    AnalyticsService.pressRateLesson(lesson.courseId, lesson.id, rating);
    try {
      lessonDetails?.rating = rating;
      notifyListeners();
      await lessonRepository.rateLesson(lesson.courseId, lesson.id, rating);
    } catch (e) {
      toastDioError(e);
      lessonDetails?.rating = null;
      notifyListeners();
    }
  }

  @override
  editRating() {
    AnalyticsService.pressEditLessonRating(lesson.courseId, lesson.id);
    lessonDetails?.rating = null;
    notifyListeners();
  }

  @override
  void editQuestion(String value) {
    question = value;
  }

  @override
  askQuestion() async {
    AnalyticsService.pressAskLessonQuestion(lesson.courseId, lesson.id);
    try {
      await lessonRepository.askQuestion(lesson.courseId, lesson.id, question);
      lessonDetails?.question?.value = question;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      notifyListeners();
    }
  }

  @override
  void editHomeworkSubmission(HomeworkSubmission submission) {
    lessonDetails?.homework?.submission = submission;
    setLessonPassedIfNeeded();
    notifyListeners();
  }

  @override
  bool isTestPassed() {
    if (lessonDetails == null) return false;
    if (lessonDetails?.test == null) {
      return true;
    } else {
      final result = lessonDetails?.test?.isPassed ?? false;
      if (!result) {
        toastDioError("Pass test first");
      }

      return result;
    }
  }

  @override
  void editTestSubmission(TestSubmission submission) {
    lessonDetails?.test?.submission = submission;
    setLessonPassedIfNeeded();
    notifyListeners();
  }

  @override
  void downloadLessonResource(LessonResource resource) async {
    try {
      AnalyticsService.pressDownloadLessonResource(
          resource.courseId, resource.lessonId, resource.id);
      loadingResources.add(resource.id);
      notifyListeners();
      final url = await lessonRepository.getLessonResourceDownloadUrl(
          resource.courseId, resource.lessonId, resource.id);
      if (await canLaunchUrl(Uri.parse(url))) {
        loadingResources.remove(resource.id);
        controller.pause();
        notifyListeners();
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      toastDioError(e);
      loadingResources.remove(resource.id);
      notifyListeners();
    }
  }

  @override
  void downloadHomeworkResource(HomeworkResource resource) async {
    try {
      AnalyticsService.pressDownloadHomeworkResource(
          resource.courseId, resource.homeworkId, "lesson");
      isDownloadingHomeworkResource = true;
      notifyListeners();
      final url = await homeworkRepository.getHomeworkResourceDownloadUrl(
          resource.courseId, resource.homeworkId);
      if (await canLaunchUrl(Uri.parse(url))) {
        isDownloadingHomeworkResource = false;
        controller.pause();
        notifyListeners();
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      toastDioError(e);
      isDownloadingHomeworkResource = false;
      notifyListeners();
    }
  }

  @override
  void pauseVideo() {
    controller.pause();
  }

  setLessonPassedIfNeeded() {
    final temp = lessonDetails;
    if (temp == null) return;
    bool isTestPassed = false;
    bool isHomeworkPassed = false;
    if (temp.test == null) {
      isTestPassed = true;
    } else {
      isTestPassed = temp.test?.isPassed ?? false;
    }
    if (temp.homework == null) {
      isHomeworkPassed = true;
    } else {
      isHomeworkPassed = temp.homework?.isPassed ?? false;
    }
    if (isTestPassed && isHomeworkPassed) {
      delegate.setLessonPassed(lesson);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
