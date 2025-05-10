import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

NetworkService get networkService => Get.find();

var client = http.Client();
var token = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';
var category = 'general';

String publicHost =
    "https://finnhub.io/api/v1/news?category=$category&token=$token"; // test

// String sdkBaseUrl = ""; // Test
String sdkBaseUrl = ""; // Live
var logger = log("NetworkService");

class NetworkService {
  static Uri buildUrl(
      {required String endpoint, Map<String, dynamic>? params}) {
    final apiPath = "$publicHost$endpoint";

    if (params != null && params.isNotEmpty) {
      final uri = Uri.parse(apiPath);
      return uri.replace(
          queryParameters:
              params.map((key, value) => MapEntry(key, value.toString())));
    }

    return Uri.parse(apiPath);
  }

  static const int tokenExpiredCode = 401;

  static Future<http.Response> _handleRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode == tokenExpiredCode) {
        // Token expired, attempt refresh
        // final refreshed = await _refreshToken();
        final refreshed = await false;
        if (refreshed) {
          // Retry original request with new token
          return await request();
        }
      }
      return response;
    } catch (e) {
      log("Network error: $e");
      rethrow;
    }
  }

  // Get request

  static Future<http.Response> getDataWithAuth(
      {required String endpoint, dynamic body}) async {
    return _handleRequest(() async {
      // final token = await TokenService.getAccessToken();
      return await client.get(buildUrl(endpoint: "https://finnhub.io/api/v1/news?category=general&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg", params: body),
          headers: {"Accept": "*/*"});
    });
  }



static Future<http.Response> getExternalApi({required String url}) async {
  try {
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {"Accept": "*/*"});
    return response;
  } catch (e) {
    log("External API error: $e");
    rethrow;
  }
}

}
