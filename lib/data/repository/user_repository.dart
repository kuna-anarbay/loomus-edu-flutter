import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/user_api.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/user/user.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository(this.userApi);

  Future<User> getMyProfile() async {
    try {
      final response = await userApi.getMyProfile();
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> editProfile(String firstName, String? lastName, int? birthday,
      String? gender, String color, String theme, String language) async {
    try {
      await userApi.editProfile(
          firstName, lastName, birthday, gender, color, theme, language);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> editPassword(String oldPassword, String newPassword) async {
    try {
      await userApi.editPassword(oldPassword, newPassword);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> editDeviceToken(String deviceToken, String refreshToken) async {
    try {
      await userApi.editDeviceToken(deviceToken, refreshToken);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteProfile() async {
    try {
      await userApi.deleteProfile();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> editAvatar(File file) async {
    try {
      final response = await userApi.editAvatar(file);
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteAvatar() async {
    try {
      await userApi.deleteAvatar();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
