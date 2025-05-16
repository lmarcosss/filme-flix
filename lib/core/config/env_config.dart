class EnvConfig {
  static EnvConfig get instance {
    if (_instance == null) {
      const apiKey = String.fromEnvironment("API_KEY");
      const baseUrl = String.fromEnvironment("BASE_URL");
      const apiToken = String.fromEnvironment("API_TOKEN");
      _instance = EnvConfig._internal(apiKey, baseUrl, apiToken);

      return _instance!;
    }
    return _instance!;
  }

  static EnvConfig? _instance;
  EnvConfig._internal(this.apiKey, this.baseUrl, this.apiToken);

  final String apiKey;
  final String baseUrl;
  final String apiToken;
}
