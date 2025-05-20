import 'package:dio/io.dart';
import 'package:filme_flix/core/client/interceptor/auth_interceptor.dart';
import 'package:filme_flix/core/client/interceptor/error_interceptor.dart';
import 'package:filme_flix/core/config/env_config.dart';

class ApiClient extends DioForNative {
  ApiClient() {
    options.baseUrl = EnvConfig.instance.baseUrl;

    interceptors.add(AuthInterceptor());
    interceptors.add(InterceptorError());
  }
}
