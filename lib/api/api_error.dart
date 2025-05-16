import 'package:dio/dio.dart';

class ApiError extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response?.data != null) {
      final data = err.response?.data;

      if (data is Map && data['status_message'] != null) {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: data['status_message'],
        );
      }
    }

    return handler.next(err);
  }
}
