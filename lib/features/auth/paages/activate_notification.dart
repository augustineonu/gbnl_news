import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbnl_news/features/news_feed/data/view_model/news_feed_vm.dart';
import 'package:gbnl_news/features/news_feed/pages/news_feed.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivateNotification extends StatefulWidget {
  const ActivateNotification({super.key,
  required this.fullName});
  final String fullName;

  @override
  State<ActivateNotification> createState() => _ActivateNotificationState();
}

class _ActivateNotificationState extends State<ActivateNotification> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final newsFeedViewModel = Get.put(NewsFeedViewModel());
  @override
  void initState() {
    super.initState();

    newsFeedViewModel.fetchNews();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _requestNotificationPermission();
    super.didChangeDependencies();
  }

  Future<void> _requestNotificationPermission() async {
    // For iOS, this will trigger the system dialog
    if (Theme.of(context).platform == TargetPlatform.iOS) {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
    // For Android, use permission_handler
    else {
      final status = await Permission.notification.request();

      String message = '';
      if (status.isGranted) {
        message = 'Notification permissions granted';
      } else if (status.isDenied) {
        message = 'Notification permissions denied';
      } else if (status.isPermanentlyDenied) {
        message = 'Notification permissions permanently denied, open settings';
        await openAppSettings();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // const SizedBox(height: 16.0),
              SvgPicture.asset('assets/svg/Icon.svg'),
              const SizedBox(height: 12.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get the most out of Blott ✅',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Allow notifications to stay in the loop with your payments, requests and groups.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor500,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => NewsFeedPage(
                          fullName: widget.fullName,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: textWhite,
                    ),
                  )),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
