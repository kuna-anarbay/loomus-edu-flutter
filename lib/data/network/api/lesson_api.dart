import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';

import '../dio_client.dart';

class LessonApi {
  final DioClient dioClient;

  LessonApi({required this.dioClient});

  Future<Response<String>> getAllLessons(int courseId) async {
    try {
      return await dioClient.get(Endpoints.sections(courseId));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<String>> getVisibleLessons(int courseId) async {
    try {
      return await dioClient.get(Endpoints.visibleSections(courseId));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLesson(int courseId, int lessonId) async {
    try {
      final Response response =
          await dioClient.get(Endpoints.lesson(courseId, lessonId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> rateLesson(int courseId, int lessonId, int rating) async {
    try {
      final Response response = await dioClient.put(
          Endpoints.lessonRating(courseId, lessonId),
          data: {"rating": rating});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLessonResourceDownloadUrl(
      int courseId, int lessonId, int resourceId) async {
    try {
      final Response response = await dioClient.get(
          Endpoints.lessonResourceDownloadUrl(courseId, lessonId, resourceId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> askQuestion(int courseId, int lessonId, String value) async {
    try {
      final Response response = await dioClient.post(
          Endpoints.lessonQuestion(courseId, lessonId),
          data: {"value": value});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
