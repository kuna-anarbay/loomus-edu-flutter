import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loomus_app/data/network/api/auth_api.dart';
import 'package:loomus_app/data/network/api/course_api.dart';
import 'package:loomus_app/data/network/api/homework_api.dart';
import 'package:loomus_app/data/network/api/lesson_api.dart';
import 'package:loomus_app/data/network/api/user_api.dart';
import 'package:loomus_app/data/network/dio_client.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';
import 'package:loomus_app/data/repository/course_repository.dart';
import 'package:loomus_app/data/repository/homework_repository.dart';
import 'package:loomus_app/data/repository/lesson_repository.dart';
import 'package:loomus_app/data/repository/test_repository.dart';
import 'package:loomus_app/data/repository/user_repository.dart';
import 'package:loomus_app/modules/auth/login/login_view_model.dart';
import 'package:loomus_app/modules/auth/register/register_view_model.dart';
import 'package:loomus_app/modules/auth/reset_password/reset_password_view_model.dart';
import 'package:loomus_app/modules/common/onboarding/onboarding_view_model.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/modules/demo/demo_view_model.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_view_model.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/modules/homework/homework_terms/homework_terms_view_model.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/modules/profile/profile_view_model.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/modules/test/test_terms/test_terms_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/services/local_storage.dart';
import 'package:loomus_app/services/notifications_service.dart';

import '../data/network/api/test_api.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(LocalStorage());
  getIt.registerSingleton(AnalyticsService());
  getIt.registerSingleton(DioClient(getIt(), getIt()));
  getIt.registerSingleton(AuthApi(dioClient: getIt()));
  getIt.registerSingleton(UserApi(dioClient: getIt()));
  getIt.registerSingleton(CourseApi(dioClient: getIt()));
  getIt.registerSingleton(LessonApi(dioClient: getIt()));
  getIt.registerSingleton(HomeworkApi(dioClient: getIt()));
  getIt.registerSingleton(TestApi(dioClient: getIt()));
  getIt.registerSingleton(AuthRepository(getIt.get()));
  getIt.registerSingleton(UserRepository(getIt.get()));
  getIt.registerSingleton(CourseRepository(getIt.get()));
  getIt.registerSingleton(LessonRepository(getIt.get()));
  getIt.registerSingleton(HomeworkRepository(getIt.get()));
  getIt.registerSingleton(TestRepository(getIt.get()));
  getIt.registerSingleton(NotificationsService(getIt.get(), getIt.get()));

  getIt.registerFactory(() => OnboardingViewModel());

  getIt.registerFactory(
      () => LoginViewModel(getIt.get(), getIt.get(), getIt.get()));

  getIt.registerFactoryParam<RegisterViewModel, RegisterDataSource, void>(
      (dataSource, _) =>
          RegisterViewModel(dataSource, getIt.get(), getIt.get(), getIt.get()));

  getIt.registerFactoryParam<ResetPasswordViewModel, ResetPasswordDataSource,
          void>(
      (dataSource, _) => ResetPasswordViewModel(
          dataSource, getIt.get(), getIt.get(), getIt.get()));

  getIt.registerFactoryParam<ProfileViewModel, ProfileDataSource, void>(
      (dataSource, _) =>
          ProfileViewModel(dataSource, getIt.get(), getIt.get()));

  getIt.registerFactoryParam<EditProfileViewModel, EditProfileDataSource,
          EditProfileDelegate>(
      (dataSource, delegate) => EditProfileViewModel(
          dataSource, delegate, getIt.get(), getIt.get(), getIt.get()));

  getIt.registerFactoryParam<HomeViewModel, HomeDataSource, void>(
      (dataSource, _) => HomeViewModel(dataSource, getIt.get(), getIt.get()));

  getIt.registerFactoryParam<CourseViewModel, CourseDataSource, CourseDelegate>(
      (dataSource, delegate) =>
          CourseViewModel(dataSource, delegate, getIt.get(), getIt.get()));

  getIt.registerFactoryParam<DemoViewModel, DemoDataSource, void>(
      (dataSource, _) => DemoViewModel(dataSource, getIt.get(), getIt.get()));

  getIt.registerFactoryParam<LessonViewModel, LessonDataSource, LessonDelegate>(
      (dataSource, delegate) =>
          LessonViewModel(dataSource, delegate, getIt.get(), getIt.get()));

  getIt.registerFactoryParam<HomeworkViewModel, HomeworkDataSource,
          HomeworkDelegate>(
      (dataSource, delegate) =>
          HomeworkViewModel(dataSource, delegate, getIt.get()));

  getIt.registerFactoryParam<TestViewModel, TestDataSource, TestDelegate>(
      (dataSource, delegate) =>
          TestViewModel(dataSource, delegate, getIt.get()));

  getIt.registerFactoryParam<TestTermsViewModel, TestTermsDataSource,
          TestDelegate>(
      (dataSource, delegate) =>
          TestTermsViewModel(dataSource, delegate, getIt.get()));

  getIt.registerFactoryParam<HomeworkTermsViewModel, HomeworkTermsDataSource,
          HomeworkDelegate>(
      (dataSource, delegate) =>
          HomeworkTermsViewModel(dataSource, delegate, getIt.get()));
}
