import 'package:dio/dio.dart';
import 'package:loomus_app/data/network/dio_exception.dart';
import 'package:loomus_app/models/auth/token_data.dart';

import '../network/api/auth_api.dart';

class AuthRepository {
  final AuthApi authApi;

  AuthRepository(this.authApi);

  Future<void> getEmailVerificationCode(String email, String purpose) async {
    try {
      await authApi.getEmailVerificationCode(email, purpose);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TokenData> signUp(String firstName, String lastName, String email,
      String password, String code) async {
    try {
      final response =
          await authApi.signUp(firstName, lastName, email, password, code);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      throw errorMessage;
    }
  }

  Future<TokenData> signIn(String email, String password) async {
    try {
      final response = await authApi.signIn(email, password);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TokenData> signInWithApple(String token) async {
    try {
      final response = await authApi.signInWithApple(token);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TokenData> signInWithGoogle(String token) async {
    try {
      final response = await authApi.signInWithGoogle(token);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TokenData> resetPassword(
      String email, String password, String code) async {
    try {
      final response = await authApi.resetPassword(email, password, code);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> getSmsVerificationCode(String phone) async {
    try {
      await authApi.getSmsVerificationCode(phone);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TokenData> verifyPhoneNumber(String phone, String code) async {
    try {
      final response = await authApi.verifyPhoneNumber(phone, code);
      return TokenData.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> refreshToken(String refreshToken) async {
    try {
      await authApi.refreshToken(refreshToken);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> signOut(String refreshToken) async {
    try {
      await authApi.signOut(refreshToken);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
