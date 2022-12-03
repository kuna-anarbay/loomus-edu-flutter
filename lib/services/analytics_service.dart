import 'package:amplitude_flutter/amplitude.dart';

class AnalyticsService {
  static final Amplitude amplitude = Amplitude.getInstance();

  ///
  /// Page opens
  ///

  static openedPageSignIn() {
    amplitude.logEvent("opened_page_sign_in");
  }

  static openedPageHome() {
    amplitude.logEvent("opened_page_home");
  }

  static openedPageSignUp() {
    amplitude.logEvent("opened_page_sign_up");
  }

  static openedPageResetPassword() {
    amplitude.logEvent("opened_page_reset_password");
  }

  static openedPageCourse(int courseId) {
    amplitude.logEvent("opened_page_course",
        eventProperties: {"courseId": "$courseId"});
  }

  static openedPageDemo(int courseId) {
    amplitude.logEvent("opened_page_demo",
        eventProperties: {"courseId": "$courseId"});
  }

  static openedPageLesson(int courseId, int lessonId) {
    amplitude.logEvent("opened_page_lesson",
        eventProperties: {"courseId": "$courseId", "lessonId": "$lessonId"});
  }

  static openedPageTest(int courseId, int testId) {
    amplitude.logEvent("opened_page_test",
        eventProperties: {"courseId": "$courseId", "testId": "$testId"});
  }

  static openedPageTestTerms(int courseId, int testId) {
    amplitude.logEvent("opened_page_test_terms",
        eventProperties: {"courseId": "$courseId", "testId": "$testId"});
  }

  static openedPageHomework(int courseId, int homeworkId) {
    amplitude.logEvent("opened_page_homework", eventProperties: {
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static openedPageHomeworkTerms(int courseId, int homeworkId) {
    amplitude.logEvent("opened_page_homework_terms", eventProperties: {
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static openedPageProfile(int userId) {
    amplitude.logEvent("opened_page_profile",
        eventProperties: {"userId": "$userId"});
  }

  static openedPageEditProfile(int userId) {
    amplitude.logEvent("opened_page_edit_profile",
        eventProperties: {"userId": "$userId"});
  }

  ///
  /// Presses
  ///

  static pressOpenPageResetPassword() {
    amplitude.logEvent("press_open_page_reset_password",
        eventProperties: {"page": "sign_in"});
  }

  static pressOpenPageSignUp() {
    amplitude.logEvent("press_open_page_sign_up",
        eventProperties: {"page": "sign_in"});
  }

  static pressSignIn() {
    amplitude.logEvent("press_sign_in", eventProperties: {"page": "sign_in"});
  }

  static pressSignInWithApple() {
    amplitude.logEvent("press_sign_in_with_apple",
        eventProperties: {"page": "sign_in"});
  }

  static pressSignInWithGoogle() {
    amplitude.logEvent("press_sign_in_with_google",
        eventProperties: {"page": "sign_in"});
  }

  static pressSignUp() {
    amplitude.logEvent("press_sign_up", eventProperties: {"page": "sign_up"});
  }

  static pressRequestEmailCode(String page) {
    amplitude
        .logEvent("press_request_email_code", eventProperties: {"page": page});
  }

  static pressResetPassword() {
    amplitude.logEvent("press_reset_password",
        eventProperties: {"page": "reset_password"});
  }

  static pressOpenPageProfile() {
    amplitude
        .logEvent("press_open_page_profile", eventProperties: {"page": "home"});
  }

  static pressOpenPageCourse(int courseId) {
    amplitude.logEvent("press_open_page_course",
        eventProperties: {"page": "home", "courseId": "$courseId"});
  }

  static pressOpenPageDemo(int courseId) {
    amplitude.logEvent("press_open_page_demo",
        eventProperties: {"page": "home", "courseId": "$courseId"});
  }

  static pressOpenPageLesson(int courseId, int lessonId, String page) {
    amplitude.logEvent("press_open_page_lesson", eventProperties: {
      "page": page,
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressContinueLearning(int courseId, int lessonId) {
    amplitude.logEvent("press_continue_learning", eventProperties: {
      "page": "course",
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressOpenLesson(int courseId, int lessonId, String page) {
    amplitude.logEvent("press_open_lesson", eventProperties: {
      "page": page,
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressOpenFullProgram(int courseId) {
    amplitude.logEvent("press_open_full_program",
        eventProperties: {"page": "demo", "courseId": "$courseId"});
  }

  static pressDownloadLessonResource(
      int courseId, int lessonId, int resourceId) {
    amplitude.logEvent("press_download_lesson_resource", eventProperties: {
      "page": "lesson",
      "courseId": "$courseId",
      "lessonId": "$lessonId",
      "resourceId": "$resourceId"
    });
  }

  static pressDownloadHomeworkResource(
      int courseId, int homeworkId, String page) {
    amplitude.logEvent("press_download_homework_resource", eventProperties: {
      "page": "lesson",
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static pressRateLesson(int courseId, int lessonId, int rating) {
    amplitude.logEvent("press_rate_lesson", eventProperties: {
      "page": "lesson",
      "rating": "$rating",
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressEditLessonRating(int courseId, int lessonId) {
    amplitude.logEvent("press_edit_lesson_rating", eventProperties: {
      "page": "lesson",
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressOpenPageTest(
      int courseId, int testId, String page, bool isPassed) {
    amplitude.logEvent("press_open_page_test", eventProperties: {
      "page": page,
      "isPassed": isPassed,
      "courseId": "$courseId",
      "testId": "$testId"
    });
  }

  static pressOpenPageTestInstructions(int courseId, int testId) {
    amplitude.logEvent("press_open_page_test_instructions", eventProperties: {
      "page": "lesson",
      "courseId": "$courseId",
      "testId": "$testId"
    });
  }

  static pressOpenPageHomework(int courseId, int homeworkId, String page) {
    amplitude.logEvent("press_pass_homework", eventProperties: {
      "page": page,
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static pressOpenPageHomeworkInstructions(int courseId, int homeworkId) {
    amplitude.logEvent("press_open_page_homework_instructions",
        eventProperties: {
          "page": "lesson",
          "courseId": "$courseId",
          "homeworkId": "$homeworkId"
        });
  }

  static pressAskLessonQuestion(int courseId, int lessonId) {
    amplitude.logEvent("press_ask_lesson_question", eventProperties: {
      "page": "lesson",
      "courseId": "$courseId",
      "lessonId": "$lessonId"
    });
  }

  static pressDontShowTestInstructions(int courseId, int testId, bool hidden) {
    amplitude.logEvent("press_dont_show_test_instructions", eventProperties: {
      "page": "test_instructions",
      "hidden": "$hidden",
      "courseId": "$courseId",
      "testId": "$testId"
    });
  }

  static pressDontShowHomeworkInstructions(
      int courseId, int homeworkId, bool hidden) {
    amplitude
        .logEvent("press_dont_show_homework_instructions", eventProperties: {
      "page": "homework_instructions",
      "hidden": "$hidden",
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static pressRemoveHomeworkSubmissionImage(int courseId, int homeworkId) {
    amplitude.logEvent("press_remove_homework_submission_image",
        eventProperties: {
          "page": "homework",
          "courseId": "$courseId",
          "homeworkId": "$homeworkId"
        });
  }

  static pressAttachHomeworkSubmissionImage(int courseId, int homeworkId) {
    amplitude.logEvent("press_attach_homework_submission_image",
        eventProperties: {
          "page": "homework",
          "courseId": "$courseId",
          "homeworkId": "$homeworkId"
        });
  }

  static pressSelectHomeworkSubmissionImage(
      int courseId, int homeworkId, String imageSource) {
    amplitude
        .logEvent("press_select_homework_submission_image", eventProperties: {
      "page": "homework",
      "imageSource": imageSource,
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static pressSubmitHomework(int courseId, int homeworkId) {
    amplitude.logEvent("press_submit_homework", eventProperties: {
      "page": "homework",
      "courseId": "$courseId",
      "homeworkId": "$homeworkId"
    });
  }

  static pressSubmitTest(int courseId, int testId) {
    amplitude.logEvent("press_submit_test", eventProperties: {
      "page": "test",
      "courseId": "$courseId",
      "testId": "$testId"
    });
  }

  static pressRetryTest(int courseId, int testId) {
    amplitude.logEvent("press_retry_test", eventProperties: {
      "page": "test",
      "courseId": "$courseId",
      "testId": "$testId"
    });
  }

  static pressOpenActionSheetChangeLanguage(int userId) {
    amplitude.logEvent("press_open_action_sheet_change_language",
        eventProperties: {"page": "profile", "userId": "$userId"});
  }

  static pressChangeLanguage(int userId, String language) {
    amplitude.logEvent("press_change_language", eventProperties: {
      "page": "profile",
      "language": language,
      "userId": "$userId"
    });
  }

  static pressShareApp(int userId) {
    amplitude.logEvent("press_share_app",
        eventProperties: {"page": "profile", "userId": "$userId"});
  }

  static pressRateApp(int userId) {
    amplitude.logEvent("press_rate_app",
        eventProperties: {"page": "profile", "userId": "$userId"});
  }

  static pressOpenActionSheetSupport(int userId) {
    amplitude.logEvent("press_open_action_sheet_support",
        eventProperties: {"page": "profile", "userId": "$userId"});
  }

  static pressOpenPageEditProfile(int userId) {
    amplitude.logEvent("press_open_page_edit_profile",
        eventProperties: {"page": "profile", "userId": "$userId"});
  }

  static pressEditAvatar(int userId) {
    amplitude.logEvent("press_edit_avatar",
        eventProperties: {"page": "edit_profile", "userId": "$userId"});
  }

  static pressDeleteAvatar(int userId) {
    amplitude.logEvent("press_delete_avatar",
        eventProperties: {"page": "edit_profile", "userId": "$userId"});
  }

  static pressEditProfile(int userId) {
    amplitude.logEvent("press_edit_profile",
        eventProperties: {"page": "edit_profile", "userId": "$userId"});
  }

  static pressLogout(int userId) {
    amplitude.logEvent("press_logout",
        eventProperties: {"page": "edit_profile", "userId": "$userId"});
  }

  static pressDeleteAccount(int userId) {
    amplitude.logEvent("press_delete_account",
        eventProperties: {"page": "edit_profile", "userId": "$userId"});
  }

  static pressSelectAvatar(int userId, String imageSource) {
    amplitude.logEvent("press_select_avatar", eventProperties: {
      "page": "edit_profile",
      "imageSource": imageSource,
      "userId": "$userId"
    });
  }
}
