import 'package:get/get.dart';

AppLinks get appLinks => Get.find();

class AppLinks {
  static final AppLinks _cache = AppLinks._internal();

  factory AppLinks() {
    return _cache;
  }

  AppLinks._internal();

  static const welcome = "/";
  static const splash = "/splash";
  static const login = "/login";
  static const newsFeed = "/newsFeed";


  final links = {
    // auth routes
    "welcome": welcome,
    "splash": splash,
    "login": login,
    "newsFeed": newsFeed,
  };

  String url(String endpoint,
      {Map<String, String>? params, bool parse = true}) {
    var path = links[endpoint]!;
    if (parse) {
      path = parsePath(path, params: params);
    }
    return path;
  }

  String parsePath(String path, {Map<String, String>? params}) {
    if (params != null) {
      params.forEach((key, value) {
        path = path.replaceAll(":$key", value);
      });
    }
    final varPattern = RegExp(r'(?<!:):\w+');
    path = path.replaceAll(varPattern, '');
    final slashPattern = RegExp(r'\/+$');
    path = path.replaceAll(slashPattern, '');
    return path;
  }
}
