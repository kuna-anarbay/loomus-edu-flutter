import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';

import '../dio_client.dart';

class TestApi {
  final DioClient dioClient;

  TestApi({required this.dioClient});

  Future<Response> submitTest(
      int courseId, int testId, Map<int, List<int>> answers) async {
    try {
      final List<Map<String, dynamic>> body = [];
      answers.forEach((key, value) {
        body.add({"questionId": key, "optionIds": value});
      });
      final Response response = await dioClient.post(
          Endpoints.testSubmission(courseId, testId),
          data: {"answers": body});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getQuestions(int courseId, int testId) async {
    try {
      final Response response =
          await dioClient.get(Endpoints.testQuestions(courseId, testId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMySubmission(int courseId, int testId) async {
    try {
      final Response response =
          await dioClient.get(Endpoints.myTestSubmission(courseId, testId));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
