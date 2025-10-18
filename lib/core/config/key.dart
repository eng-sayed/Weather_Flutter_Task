class ConstKeys {
  static const devEnv = true;
  static const baseUrlDev = "https://api.openweathermap.org/data/2.5";
  static const baseUrlLive = const String.fromEnvironment("BASE_URL");
  static const moyaser = "";
  static String paymentKeyLive = '';
  static String paymentKeyTest = '';

  static const String weatherApiKey = 'cdded2f02b061824a5ec0c7fb293b750';

  static String get paymentKey => devEnv ? paymentKeyTest : paymentKeyLive;
  static String get baseUrl => devEnv ? baseUrlDev : baseUrlLive;

  static get baseNoApi {
    return baseUrl.replaceAll("/api", "");
  }
}
