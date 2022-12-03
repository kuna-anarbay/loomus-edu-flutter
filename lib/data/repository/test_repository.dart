import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/test_api.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/test/question.dart';
import 'package:loomus_app/models/test/test_submission_details.dart';

class TestRepository {
  final TestApi testApi;

  TestRepository(this.testApi);

  Future<TestSubmissionDetails> submitTest(
      int courseId, int testId, Map<int, List<int>> answers) async {
    try {
      final response = await testApi.submitTest(courseId, testId, answers);
      return TestSubmissionDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Question>> getAllQuestions(int courseId, int testId) async {
    try {
      final response = await testApi.getQuestions(courseId, testId);
      return List.from(response.data.map((l) => Question.fromJson(l)));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TestSubmissionDetails> getMySubmission(
      int courseId, int testId) async {
    try {
      final response = await testApi.getMySubmission(courseId, testId);
      return TestSubmissionDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
