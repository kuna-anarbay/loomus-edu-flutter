import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';

import '../dio_client.dart';

class CourseApi {
  final DioClient dioClient;

  CourseApi({required this.dioClient});

  Future<Response<String>> getMyCourses() async {
    try {
      return await dioClient.get(Endpoints.myCourses);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> setOpened(int courseId) async {
    try {
      final Response response = await dioClient.put(Endpoints.setCourseOpened(courseId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> setTestAgreementHidden(int courseId) async {
    try {
      final Response response = await dioClient.put(Endpoints.setTestAgreementHidden(courseId));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> setHomeworkAgreementHidden(int courseId) async {
    try {
      final Response response = await dioClient.put(Endpoints.setHomeworkAgreementHidden(courseId));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}