import 'package:dio/io.dart';
import 'package:filme_flix/app_config.dart';

class ApiClient extends DioForNative {
  ApiClient() {
    options.baseUrl = AppConfig.instance.baseUrl;
    options.headers = {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    };
  }
}
