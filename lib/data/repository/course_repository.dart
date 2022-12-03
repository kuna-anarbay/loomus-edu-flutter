import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/course_api.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/course/member_course.dart';

class CourseRepository {
  final CourseApi courseApi;

  CourseRepository(this.courseApi);

  Future<List<MemberCourse>> getMyCourses() async {
    try {
      final response = await courseApi.getMyCourses();
      final List list = json.decode(response.data ?? "[]");

      return list.map((l) => MemberCourse.fromJson(l)).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> setOpened(int courseId) async {
    try {
      await courseApi.setOpened(courseId);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> setTestAgreementHidden(int courseId) async {
    try {
      await courseApi.setTestAgreementHidden(courseId);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> setHomeworkAgreementHidden(int courseId) async {
    try {
      await courseApi.setHomeworkAgreementHidden(courseId);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
