import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/di/service_locator.dart';
import 'package:loomus_app/modules/auth/login/login_page.dart';
import 'package:loomus_app/modules/auth/login/login_view_model.dart';
import 'package:loomus_app/modules/auth/phone_verification/phone_verification_page.dart';
import 'package:loomus_app/modules/auth/phone_verification/phone_verification_view_model.dart';
import 'package:loomus_app/modules/auth/register/register_page.dart';
import 'package:loomus_app/modules/auth/register/register_view_model.dart';
import 'package:loomus_app/modules/auth/reset_password/reset_password_page.dart';
import 'package:loomus_app/modules/auth/reset_password/reset_password_view_model.dart';
import 'package:loomus_app/modules/common/launch/launch_page.dart';
import 'package:loomus_app/modules/course/course_page.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/modules/demo/demo_page.dart';
import 'package:loomus_app/modules/demo/demo_view_model.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_page.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_view_model.dart';
import 'package:loomus_app/modules/home/home_page.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/modules/homework/homework/homework_page.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/modules/homework/homework_terms/homework_terms_page.dart';
import 'package:loomus_app/modules/homework/homework_terms/homework_terms_view_model.dart';
import 'package:loomus_app/modules/lesson/lesson_page.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/modules/profile/profile_page.dart';
import 'package:loomus_app/modules/profile/profile_view_model.dart';
import 'package:loomus_app/modules/test/test/test_page.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/modules/test/test_terms/test_terms_page.dart';
import 'package:loomus_app/modules/test/test_terms/test_terms_view_model.dart';
import 'package:provider/provider.dart';

class LsRouter {
  final BuildContext context;

  LsRouter(this.context);

  push<T extends ChangeNotifier?>(Widget widget, T notifier,
      [bool fullscreenDialog = false]) {
    if (Platform.isIOS) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              fullscreenDialog: fullscreenDialog,
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => notifier, child: widget)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: fullscreenDialog,
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => notifier, child: widget)));
    }
  }

  pushReplacement<T extends ChangeNotifier?>(Widget widget, T notifier) {
    if (Platform.isIOS) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => notifier, child: widget)),
          (_) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => notifier, child: widget)),
          (_) => false);
    }
  }

  pop() {
    Navigator.pop(context);
  }

  openLogin() {
    pushReplacement(const LoginPage(), getIt.get<LoginViewModel>());
  }

  openRegister(RegisterDataSource dataSource) {
    push(
        const RegisterPage(), getIt.get<RegisterViewModel>(param1: dataSource));
  }

  openResetPassword(ResetPasswordDataSource dataSource) {
    push(const ResetPasswordPage(),
        getIt.get<ResetPasswordViewModel>(param1: dataSource));
  }

  openPhoneVerification() {
    push(
        const PhoneVerificationPage(), getIt.get<PhoneVerificationViewModel>());
  }

  openCourse(CourseDataSource dataSource, CourseDelegate delegate) {
    push(const CoursePage(),
        getIt.get<CourseViewModel>(param1: dataSource, param2: delegate));
  }

  openDemo(DemoDataSource dataSource) {
    push(const DemoPage(), getIt.get<DemoViewModel>(param1: dataSource));
  }

  openEditProfile(
      EditProfileDataSource dataSource, EditProfileDelegate delegate) {
    push(const EditProfilePage(),
        getIt.get<EditProfileViewModel>(param1: dataSource, param2: delegate));
  }

  openHomework(HomeworkDataSource dataSource, HomeworkDelegate delegate) {
    push(const HomeworkPage(),
        getIt.get<HomeworkViewModel>(param1: dataSource, param2: delegate));
  }

  openHomeworkTerms(
      HomeworkTermsDataSource dataSource, HomeworkDelegate delegate) {
    push(
        const HomeworkTermsPage(),
        getIt.get<HomeworkTermsViewModel>(
            param1: dataSource, param2: delegate));
  }

  openLesson(LessonDataSource dataSource, LessonDelegate delegate) {
    push(const LessonPage(),
        getIt.get<LessonViewModel>(param1: dataSource, param2: delegate), true);
  }

  openProfile(ProfileDataSource dataSource) {
    push(const ProfilePage(), getIt.get<ProfileViewModel>(param1: dataSource));
  }

  openTest(TestDataSource dataSource, TestDelegate delegate) {
    push(const TestPage(),
        getIt.get<TestViewModel>(param1: dataSource, param2: delegate));
  }

  openTestTerms(TestTermsDataSource dataSource, TestDelegate delegate) {
    push(const TestTermsPage(),
        getIt.get<TestTermsViewModel>(param1: dataSource, param2: delegate));
  }

  static Widget makeLogin() {
    return ChangeNotifierProvider(
      create: (_) => getIt.get<LoginViewModel>(),
      child: const LoginPage(),
    );
  }

  static Widget makeLaunch() {
    return const LaunchPage();
  }

  openHome(HomeDataSource dataSource) {
    pushReplacement(
        const HomePage(), getIt.get<HomeViewModel>(param1: dataSource));
  }

  static Widget makeHome(HomeDataSource dataSource) {
    return ChangeNotifierProvider(
      create: (_) => getIt.get<HomeViewModel>(param1: dataSource),
      child: const HomePage(),
    );
  }
}
