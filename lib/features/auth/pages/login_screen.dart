import 'package:flutter/material.dart';
import 'package:gbnl_news/features/auth/data/view_model/auth_view_model.dart';
import 'package:gbnl_news/features/news_feed/data/view_model/news_feed_vm.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';

import 'activate_notification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthViewModel authViewModel = AuthViewModel();

  NewsFeedViewModel newsFeedViewModel = NewsFeedViewModel();

  @override
  void initState() {
    super.initState();
    authViewModel.onInit();
    newsFeedViewModel.fetchNews();
    // _firstNameController.addListener(_validateForm);
    // _lastNameController.addListener(_validateForm);
  }

  // @override
  // void dispose() {
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Your legal name',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'We need to know a bit about you so that we can create your account.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: textColor500,
                  ),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: authViewModel.firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: authViewModel.lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => authViewModel.continueToNextPage(),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: authViewModel.isFormValid.value
                        ? authViewModel.continueToNextPage
                        : null,
                    backgroundColor: authViewModel.isFormValid.value
                        ? primaryColor
                        : primaryColor.withOpacity(0.5),
                    elevation: authViewModel.isFormValid.value ? 4.0 : 0.0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      }),
    );
  }
}
