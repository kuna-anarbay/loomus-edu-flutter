import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:loomus_app/data/network/api/constant/endpoints.dart';
import 'package:loomus_app/models/auth/token_data.dart';
import 'package:loomus_app/services/device_info.dart';
import 'package:loomus_app/utilities/utils.dart';

import '../../services/local_storage.dart';

class DioClient {
  final Dio _dio;
  final LocalStorage _localStorage;

  DioClient(this._dio, this._localStorage) {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.options.connectTimeout = Endpoints.connectionTimeout;
    _dio.options.receiveTimeout = Endpoints.receiveTimeout;
    _dio.options.responseType = ResponseType.json;
    if (kDebugMode) {
      _dio.interceptors.add(DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ));
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _configureDio();
      final Response<T> response = await _dio.get(url,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _configureDio();
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _configureDio();
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _configureDio();
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  Future<void> _configureDio() async {
    final currentUser = await _localStorage.getCurrentUser();
    _dio.options.headers["Accept-Language"] = currentUser?.language;

    final tokenData = await _localStorage.getTokenData();
    final tokenRefreshAt = await _localStorage.getTokenRefreshedAt();
    if (tokenData == null || tokenRefreshAt == null) {
      return;
    }
    final now = Utils.seconds(DateTime.now());
    if (now - tokenRefreshAt >= tokenData.expiresIn - 30) {
      final DeviceInfo deviceInfo = await DeviceInfo.getInfo();
      try {
        final response = await _dio.post(Endpoints.refreshToken, data: {
          "refreshToken": tokenData.refreshToken,
          "deviceVersion": deviceInfo.deviceVersion,
          "appVersion": deviceInfo.appVersion,
          "deviceToken": null
        });
        final newTokenData = TokenData.fromJson(response.data);
        await _localStorage.setTokenData(newTokenData);
        await _localStorage.setTokenRefreshedAt(Utils.seconds(DateTime.now()));

        _dio.options.headers["Authorization"] =
            "Bearer ${newTokenData.accessToken}";
      } catch (e) {
        return;
      }
    } else {
      _dio.options.headers["Authorization"] = "Bearer ${tokenData.accessToken}";
    }
  }

  _handleException(Object e) {
    if (kDebugMode) {
      if (e is DioError) {
        print(e.response?.data);
      } else {
        print(e);
      }
    }
  }
}
