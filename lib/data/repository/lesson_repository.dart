import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/lesson_api.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/program/lesson_details.dart';
import 'package:loomus_app/models/program/section.dart';

class LessonRepository {
  final LessonApi lessonApi;

  LessonRepository(this.lessonApi);

  Future<List<Section>> getAllSections(int courseId) async {
    try {
      final response = await lessonApi.getAllLessons(courseId);
      final List list = json.decode(response.data ?? "[]");

      return list.map((l) => Section.fromJson(l)).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Section>> getVisibleLessons(int courseId) async {
    try {
      final response = await lessonApi.getVisibleLessons(courseId);
      final List list = json.decode(response.data ?? "[]");

      return list.map((l) => Section.fromJson(l)).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<LessonDetails> getLesson(int courseId, int lessonId) async {
    try {
      final response = await lessonApi.getLesson(courseId, lessonId);
      return LessonDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> rateLesson(int courseId, int lessonId, int rating) async {
    try {
      await lessonApi.rateLesson(courseId, lessonId, rating);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> getLessonResourceDownloadUrl(
      int courseId, int lessonId, int resourceId) async {
    try {
      final response = await lessonApi.getLessonResourceDownloadUrl(
          courseId, lessonId, resourceId);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> askQuestion(int courseId, int lessonId, String value) async {
    try {
      await lessonApi.askQuestion(courseId, lessonId, value);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
