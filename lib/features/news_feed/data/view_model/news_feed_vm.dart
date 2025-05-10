import 'dart:developer';

import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/features/news_feed/data/repository/news_feed_repo.dart';
import 'package:get/get.dart';

class NewsFeedViewModel extends GetxController {
  var logger = log('AuthViewModel');

  RxBool isLoading = false.obs;

  NewsFeedRepository newsFeedRepo = NewsFeedRepository();

  RxList<NewsArticleModel> newsFeedList = <NewsArticleModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    fetchNews();

    super.onInit();
  }

  Future fetchNews() async {
    try {
      isLoading(true);
      final response = await newsFeedRepo.getNews();
      log('viewModel::  News succes:: ${response.toString()}');
      newsFeedList.value = response; // Already a list of NewsArticleModel

      log('viewModel::  value assigned:: ${newsFeedList.toString()}');
      update();
    } catch (e) {
      log("viewModel:: fetchNews: error $e");
    } finally {
      isLoading(false);
      update();
    }
  }
}
