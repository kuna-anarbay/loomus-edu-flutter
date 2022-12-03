import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';
import 'package:path/path.dart';

import '../dio_client.dart';

class HomeworkApi {
  final DioClient dioClient;

  HomeworkApi({required this.dioClient});

  Future<Response> submitHomework(
      int courseId, int homeworkId, String value, File? file) async {
    try {
      FormData formData = FormData.fromMap({"value": value});
      if (file != null) {
        formData.fields.add(MapEntry("name", basename(file.path)));
        formData.files
            .add(MapEntry("file", await MultipartFile.fromFile(file.path)));
      }
      final Response response = await dioClient.post(
          Endpoints.homeworkSubmission(courseId, homeworkId),
          data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getHomeworkResourceDownloadUrl(
      int courseId, int homeworkId) async {
    try {
      final Response response = await dioClient
          .get(Endpoints.homeworkResourceDownloadUrl(courseId, homeworkId));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
