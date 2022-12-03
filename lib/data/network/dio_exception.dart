import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Запрос к серверу был отменен";
        break;
      case DioErrorType.connectTimeout:
        message = "Тайм-аут соединения с сервером";
        break;
      case DioErrorType.receiveTimeout:
        message = "Тайм-аут получения в связи с сервером";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Тайм-аут отправки в связи с сервером";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'Нет соединения с интернетом';
          break;
        }
        message = "Произошла непредвиденная ошибка";
        break;
      default:
        message = "Что-то пошло не так";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? 'Неверный запрос';
      case 401:
        return error['message'] ?? 'Вы не авторизованы';
      case 403:
        return error['message'] ?? 'Запрос запрещен';
      case 404:
        return error['message'] ?? "Не найдено";
      case 500:
        return error['message'] ?? 'Внутренняя ошибка сервера';
      case 502:
        return error['message'] ?? 'Плохой шлюз';
      default:
        return error['message'] ?? 'Упс! Что-то пошло не так';
    }
  }

  @override
  String toString() => message;
}
