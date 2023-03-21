// ignore_for_file: constant_identifier_names

// ignore: duplicate_ignore
class AppConfig {
  static const bool app_mode_debug = false;

  // api section
  //need to change with main url of api
  static const String baseUrl = "https://fakestoreapi.com";

  //need to change with api directroy
  static const String apiUrl = "$baseUrl/api/v2";

  // parametar section
  static const String LOGIN = "isLogin";
  static const String INTRO_VIEWED = "isIntroViewed";

  // base value
  static const TOKEN = "token";
}
