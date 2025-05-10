import 'dart:convert';
import 'dart:developer';

import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/helpers/exception_helper.dart';
import 'package:gbnl_news/helpers/network.dart';

import '../../../../helpers/api_response_model.dart';

class NewsFeedRepository {
  var logger = log("NewsFeedRepository");

Future<List<NewsArticleModel>> getNews() async {
  try {
    const url = 'https://finnhub.io/api/v1/news?category=general&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';
    final response = await NetworkService.getExternalApi(url: url);

    if (response.statusCode.toString().startsWith('2')) {
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
    } else {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
        data: response.body,
      );
    }
  } catch (e) {
    log("Error getNews: ${e.toString()}");
    rethrow;
  }
}

}

