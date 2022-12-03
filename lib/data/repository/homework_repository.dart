import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/homework/homework_submission.dart';

import '../network/api/homework_api.dart';

class HomeworkRepository {
  final HomeworkApi homeworkApi;

  HomeworkRepository(this.homeworkApi);

  Future<HomeworkSubmission> submitHomework(
      int courseId, int homeworkId, String value, File? file) async {
    try {
      final response =
          await homeworkApi.submitHomework(courseId, homeworkId, value, file);
      return HomeworkSubmission.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> getHomeworkResourceDownloadUrl(
      int courseId, int homeworkId) async {
    try {
      final response = await homeworkApi.getHomeworkResourceDownloadUrl(
          courseId, homeworkId);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
