import 'package:dio/dio.dart';
import 'package:filme_flix/core/config/env_config.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = EnvConfig.instance.apiToken;
    options.headers['Authorization'] = 'Bearer $token';

    super.onRequest(options, handler);
  }
}
