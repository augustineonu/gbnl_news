import 'package:flutter/material.dart';
import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/features/news_feed/data/view_model/news_feed_vm.dart';
import 'package:gbnl_news/features/news_feed/widget/news_feed_card.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// class NewsFeedBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<NewsFeedViewModel>(() => NewsFeedViewModel());
//   }
// }

class NewsFeedPage extends StatelessWidget {
  final String fullName;

  const NewsFeedPage({
    Key? key,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample news articles data
    // final List<NewsArticle> newsArticles = [
    //   NewsArticle(
    //     source: 'THE ECONOMIC TIMES',
    //     headline: 'Markets FTSE slides almost 2pc as sterling sinks to \$1.38',
    //     imageUrl: 'assets/png/Img.png',
    //     date: DateTime(2021, 6, 12),
    //   ),
    //   NewsArticle(
    //     source: 'DAILYFOREX.COM',
    //     headline:
    //         'Sensex ekes out small gain, Nifty50 ends flat; 2 Adani stocks rally up to 9%',
    //     imageUrl: 'assets/png/Img.png',
    //     date: DateTime(2021, 6, 13),
    //   ),
    //   NewsArticle(
    //     source: 'THE INDEPENDENT',
    //     headline: 'FTSE slumps almost 2% as UK retail sales disappoint',
    //     imageUrl: 'assets/png/Img.png',
    //     date: DateTime(2021, 6, 8),
    //   ),
    // ];

    // return Scaffold(
    //   body: GetBuilder<NewsFeedViewModel>(
    //     init: NewsFeedViewModel(),
    //     initState: (_) {},
    //     builder: (controller) {
    //       return Column(
    //         children: [
    //           Center(
    //             child: Text(
    //               'News Feed',
    //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Text(
    //             '${controller.newsFeedList.isNotEmpty ? controller.newsFeedList.first.category : "data is empty"}',
    //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //           ),
    //         ],
    //       );
    //     },
    //   ),

    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<NewsFeedViewModel>(builder: (controller) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 24),
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
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: controller.newsFeedList.length,
                //     itemBuilder: (context, index) {
                //       final article = controller.newsFeedList[index];
                //       return NewsCard(article: article);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
