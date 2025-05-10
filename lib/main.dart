import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'helpers/routing_config/routing_configs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GBNL News',
       theme: ThemeData(
        primarySwatch: Colors.deepPurple,
         useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),),
     
      initialRoute: AppLinks.splash,
      getPages: AppRoutes.pages,

      transitionDuration: const Duration(milliseconds: 400),
      defaultTransition: Transition.rightToLeftWithFade,
      onInit: () async {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      },
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
