import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gbnl_news/features/auth/pages/activate_notification.dart';
import 'package:gbnl_news/features/auth/pages/login_screen.dart';
import 'package:gbnl_news/features/news_feed/pages/news_feed.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthViewModel extends GetxController {
  var logger = log('AuthViewModel');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Rx<bool> isFormValid = false.obs;

  void validateForm() {
    // update() {
    isFormValid.value = firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty;
    // }
    update();
  }

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

  @override
  void onReady() {
    firstNameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    super.onReady();
  }

  // methods
  // void routeToPrivacyPolicy() {
  //   routeService.gotoRoute(AppLinks.privacyPolicyPage,
  //       arguments: {"url": privacyPolicyUrl});
  // }

  void continueToNextPage() async {
    if (isFormValid.value) {
      // // Handle navigation to next page
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   SnackBar(
      //     behavior: SnackBarBehavior.floating,
      //     margin: const EdgeInsets.only(bottom: 100.0),
      //     content: Text(
      //         'Account creation started for ${firstNameController.text} ${lastNameController.text}'),
      //     duration: const Duration(seconds: 2),
      //   ),
      // );

      final hasPermission =
          await checkAndRequestNotificationPermission(Get.context!);

      if (hasPermission) {
        Get.snackbar(
          "Success",
          '',
          messageText: Container(),
          colorText: white,
          snackPosition: SnackPosition.TOP,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          backgroundColor: Colors.green.withOpacity(0.8),
          // icon: const Icon(Icons.check),
        );
        Get.to(() => NewsFeedPage(
              fullName:
                  '${firstNameController.text} ${lastNameController.text}',
            ));
      } else {
        Get.offAll(() => Get.to(() => ActivateNotification(
            fullName:
                '${firstNameController.text} ${lastNameController.text}')));
      }

      // Get.to(() => ActivateNotification(
      //     fullName: '${firstNameController.text} ${lastNameController.text}'));
    }
  }

  Future<bool> checkAndRequestNotificationPermission(
      BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      return result == true;
    } else {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings(); // optional
      }

      return false;
    }
  }

  Future<void> requestNotificationPermission() async {
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

      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
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
        Get.to(() => NewsFeedPage(
              fullName:
                  '${firstNameController.text} ${lastNameController.text}',
            ));
      } else if (status.isDenied) {
        message = 'Notification permissions denied';
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

        await openAppSettings();
      } else if (status.isPermanentlyDenied) {
        // ignore: use_build_context_synchronously
        message = 'Notification permissions permanently denied, open settings';
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
        await openAppSettings();
      }
    }
  }
}
