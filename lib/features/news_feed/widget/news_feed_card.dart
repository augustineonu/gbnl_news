import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:gbnl_news/helpers/utils/utils.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final NewsArticleModel article;

  const NewsCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          openExternalUrl(article.url ??  'https://google.com/');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: article.image ?? '',

                width: 100,
                height: 100,
                // fit: BoxFit.cover,
                // // In a real app, you would use NetworkImage for remote images:
                // // Image.network(article.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
                // // Use a placeholder for demo purposes
                // errorBuilder: (context, error, stackTrace) {
                //   return Container(
                //     width: 100,
                //     height: 100,
                //     color: Colors.grey[800],
                //     child: const Icon(Icons.image, color: Colors.white60),
                //   );
                // },
              ),
            ),
            const SizedBox(width: 16),
            // News text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source ?? '',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        formatDate(article.datetime),
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.headline ?? '',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
