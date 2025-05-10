import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gbnl_news/features/auth/paages/login_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthViewModel extends GetxController {
  var logger = log('AuthViewModel');
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

        // Initialize the notification plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => const LoginScreen());
    });
  }

  // methods
  // void routeToPrivacyPolicy() {
  //   routeService.gotoRoute(AppLinks.privacyPolicyPage,
  //       arguments: {"url": privacyPolicyUrl});
  // }
}
