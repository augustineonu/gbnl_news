import 'package:flutter/material.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';

import 'activate_notification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _firstNameController.text.trim().isNotEmpty &&
          _lastNameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _continueToNextPage() {
    if (_isFormValid) {
      // Handle navigation to next page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Account creation started for ${_firstNameController.text} ${_lastNameController.text}'),
          duration: const Duration(seconds: 2),
        ),
      );
      Get.to(() => ActivateNotification(
        fullName: '${_firstNameController.text} ${_lastNameController.text}'
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  color: textColor
                ),
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
                controller: _firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First name',
                ),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last name',
                ),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _continueToNextPage(),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: _isFormValid ? _continueToNextPage : null,
                  backgroundColor: _isFormValid
                      ? primaryColor
                      : primaryColor.withOpacity(0.5),
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 30,
                  ),
                  elevation: _isFormValid ? 4.0 : 0.0,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
