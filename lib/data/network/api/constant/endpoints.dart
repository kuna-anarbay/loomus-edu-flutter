class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.loomus.io";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  // auth
  static const String verificationCode = "/v1/auth/email/verification-code";
  static const String signUp = "/v1/auth/sign-up";
  static const String signIn = "/v1/auth/sign-in";
  static const String signInWithApple = "/v1/auth/sign-in/apple";
  static const String signInWithGoogle = "/v1/auth/sign-in/google";
  static const String smsVerificationCode = "/v1/auth/phone/verification-code";
  static const String smsVerify = "/v1/auth/phone/verify";
  static const String resetPassword = "/v1/auth/reset-password";
  static const String refreshToken = "/v1/auth/refresh-token";
  static const String signOut = "/v1/auth/sign-out";

  static const String myProfile = "/v1/user/me";
  static const String editProfile = "/v1/user";
  static const String editPassword = "/v1/user/password";
  static const String deleteProfile = "/v1/user";
  static const String deviceToken = "/v1/user/session/device-token";

  static const String editAvatar = "/v1/user/avatar";
  static const String deleteAvatar = "/v1/user/avatar";

  static const String myCourses = "/v1/course";
  static String setCourseOpened(int courseId) {
    return "/v1/course/$courseId/opened";
  }

  static String setTestAgreementHidden(int courseId) {
    return "/v1/course/$courseId/test-agreement-hidden";
  }

  static String setHomeworkAgreementHidden(int courseId) {
    return "/v1/course/$courseId/homework-agreement-hidden";
  }

  static String sections(int courseId) {
    return "/v1/course/$courseId/section";
  }

  static String visibleSections(int courseId) {
    return "/v1/course/$courseId/section/visible";
  }

  static String lesson(int courseId, int lessonId) {
    return "/v1/course/$courseId/lesson/$lessonId";
  }

  static String lessonRating(int courseId, int lessonId) {
    return "/v1/course/$courseId/lesson/$lessonId/rating";
  }

  static String lessonQuestion(int courseId, int lessonId) {
    return "/v1/course/$courseId/lesson/$lessonId/student-question";
  }

  static String lessonResourceDownloadUrl(
      int courseId, int lessonId, int resourceId) {
    return "/v1/course/$courseId/lesson/$lessonId/resource/$resourceId/download-url";
  }

  static String homeworkSubmission(int courseId, int homeworkId) {
    return "/v1/course/$courseId/homework/$homeworkId/submission";
  }

  static String homeworkResourceDownloadUrl(int courseId, int homeworkId) {
    return "/v1/course/$courseId/homework/$homeworkId/resource/download-url";
  }

  static String testSubmission(int courseId, int testId) {
    return "/v1/course/$courseId/test/$testId/submission";
  }

  static String testQuestions(int courseId, int testId) {
    return "/v1/course/$courseId/test/$testId/question";
  }

  static String myTestSubmission(int courseId, int testId) {
    return "/v1/course/$courseId/test/$testId/submission/my";
  }
}
