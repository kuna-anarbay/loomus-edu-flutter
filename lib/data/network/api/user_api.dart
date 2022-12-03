import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';
import 'package:loomus_app/data/network/dio_client.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<Response> getMyProfile() async {
    try {
      final Response response = await dioClient.get(Endpoints.myProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editProfile(String firstName, String? lastName, int? birthday,
      String? gender, String color, String theme, String language) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.editProfile,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "birthday": birthday,
          "gender": gender,
          "color": color,
          "theme": theme,
          "language": language
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editPassword(String oldPassword, String newPassword) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.editProfile,
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editDeviceToken(String deviceToken, String refreshToken) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.deviceToken,
        data: {
          "deviceToken": deviceToken,
          "refreshToken": refreshToken
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteProfile() async {
    try {
      final Response response = await dioClient.delete(Endpoints.deleteProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editAvatar(File file) async {
    try {
      FormData formData =
          FormData.fromMap({"file": await MultipartFile.fromFile(file.path)});
      final Response response =
          await dioClient.put(Endpoints.editAvatar, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAvatar() async {
    try {
      final Response response = await dioClient.delete(Endpoints.deleteAvatar);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
