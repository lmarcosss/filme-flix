import 'package:dio/io.dart';
import 'package:filme_flix/core/config/env_config.dart';
import 'package:filme_flix/core/network/interceptor/interceptor_error.dart';

class ApiClient extends DioForNative {
  ApiClient() {
    options.baseUrl = EnvConfig.instance.baseUrl;
    options.headers = {
      'Authorization': 'Bearer ${EnvConfig.instance.apiToken}',
    };

    interceptors.add(InterceptorError());
  }
}
