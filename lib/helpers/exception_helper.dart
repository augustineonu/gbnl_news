import 'dart:async';
import 'dart:io';

String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "No internet. Check your internet connection";
  } else if (error is TimeoutException) {
    return "The request timed out";
  } else if (error is ApiException) {
    return error.message;
  } else {
    return "An error occurred, please try again";
  }
}

class ApiException implements Exception {
  final dynamic message;
  final int statusCode;
  final dynamic data;

  ApiException({required this.message, required this.statusCode, required this.data});

  @override
  String toString() => 'ApiException: $message (status code: $statusCode)';
}
