import 'package:gbnl_news/features/auth/paages/splash_screen.dart';
import 'package:gbnl_news/features/news_feed/pages/news_feed.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_links.dart';

class AppRoutes {
  static final pages = [
    GetPage(
        name: AppLinks.splash,
        page: () => const SplashScreen(),
        binding: AuthBinding()),
    GetPage(
        name: AppLinks.splash,
        page: () => const SplashScreen(),
        binding: AuthBinding()),
    GetPage(
        name: AppLinks.newsFeed,
        page: () => const NewsFeedPage(
              fullName: '',
            ),
        // binding: NewsFeedBinding(),
        ),
  ];
}
