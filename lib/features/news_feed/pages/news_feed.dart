import 'package:flutter/material.dart';
import 'package:gbnl_news/features/news_feed/data/view_model/news_feed_vm.dart';
import 'package:gbnl_news/features/news_feed/widget/news_feed_card.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';

class NewsFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsFeedViewModel>(NewsFeedViewModel());
  }
}

class NewsFeedPage extends StatelessWidget {
  final String fullName;

  const NewsFeedPage({
    super.key,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<NewsFeedViewModel>(
        init: NewsFeedViewModel(),
        initState: (_) {},
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Personalized greeting

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(color: darkBrown),
                    child: Text(
                      'Hey $fullName',
                      // 'Hey User',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // News feed list
                  if (controller.isLoading.value)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (controller.newsFeedList.isEmpty)
                    const Center(
                      child: Text(
                        'No news articles available',
                        style: TextStyle(color: white),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.newsFeedList.length,
                        itemBuilder: (context, index) {
                          final article = controller.newsFeedList[index];
                          return NewsCard(article: article);
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
