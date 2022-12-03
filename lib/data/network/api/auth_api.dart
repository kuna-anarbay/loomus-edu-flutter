import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';
import 'package:loomus_app/data/network/dio_client.dart';
import 'package:loomus_app/services/device_info.dart';
import 'package:loomus_app/utilities/constants.dart';

class AuthApi {
  final DioClient dioClient;

  AuthApi({required this.dioClient});

  Future<Response> getEmailVerificationCode(
      String email, String purpose) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.verificationCode,
        data: {
          "purpose": purpose,
          "email": email,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signUp(String firstName, String lastName, String email,
      String password, String code) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.signUp,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "code": code,
          "email": email,
          "password": password,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signIn(String email, String password) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.signIn,
        data: {
          "password": password,
          "email": email,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signInWithApple(String token) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.signInWithApple,
        data: {
          "token": token,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signInWithGoogle(String token) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.signInWithGoogle,
        data: {
          "token": token,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> resetPassword(
      String email, String code, String password) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.resetPassword,
        data: {
          "code": code,
          "email": email,
          "password": password,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSmsVerificationCode(String phone) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.smsVerificationCode,
        data: {"phone": phone},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyPhoneNumber(String phone, String code) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.smsVerify,
        data: {
          "phone": phone,
          "code": code,
          "apiKey": Constants.apiKey,
          "source": Platform.isIOS ? "IOS" : "ANDROID",
          "deviceName": deviceInfo.deviceName,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> refreshToken(String refreshToken) async {
    try {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      final Response response = await dioClient.post(
        Endpoints.refreshToken,
        data: {
          "refreshToken": refreshToken,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signOut(String refreshToken) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.signOut,
        data: {"refreshToken": refreshToken},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
