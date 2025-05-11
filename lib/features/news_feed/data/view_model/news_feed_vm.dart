import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/features/news_feed/data/repository/news_feed_repo.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NewsFeedViewModel extends GetxController {
  var logger = log('AuthViewModel');

  RxBool isLoading = false.obs;

  NewsFeedRepository newsFeedRepo = NewsFeedRepository();

  RxList<NewsArticleModel> newsFeedList = <NewsArticleModel>[].obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    // TODO: implement onInit

    fetchNews();
    super.onInit();
  }

  @override
  void onReady() {
    _requestNotificationPermission();
    super.onReady();
  }

  Future<void> _requestNotificationPermission() async {
    // For iOS, this will trigger the system dialog
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      final bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      String message = result == true
          ? 'Notification permissions granted'
          : 'Notification permissions denied';
      log("Permission:: $message");

      // ignore: use_build_Get.context!_synchronously
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //   ),
      // );
    }
    // For Android, use permission_handler
    else {
      final status = await Permission.notification.request();

      String message = '';
      if (status.isGranted) {
        message = 'Notification permissions granted';
      } else if (status.isDenied) {
        message = 'Notification permissions denied';
        // ignore: use_build_Get.context!_synchronously
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      } else if (status.isPermanentlyDenied) {
        // ignore: use_build_Get.context!_synchronously
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
        message = 'Notification permissions permanently denied, open settings';
        await openAppSettings();
      }
    }
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
