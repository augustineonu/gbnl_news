import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gbnl_news/features/news_feed/data/model/news_article_model.dart';
import 'package:gbnl_news/helpers/styles/color_styles.dart';
import 'package:gbnl_news/helpers/utils/utils.dart';

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
          openExternalUrl(article.url ?? 'https://google.com/');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News image
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: article.image ?? '',
                  width: 100,
                  height: 100,
                ),
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
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        formatDate(article.datetime),
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.headline ?? '',
                    style: const TextStyle(
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
