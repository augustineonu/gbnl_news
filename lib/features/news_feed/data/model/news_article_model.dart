// To parse this JSON data, do
//
//     final newsArticleModel = newsArticleModelFromJson(jsonString);

import 'dart:convert';

NewsArticleModel newsArticleModelFromJson(String str) => NewsArticleModel.fromJson(json.decode(str));

String newsArticleModelToJson(NewsArticleModel data) => json.encode(data.toJson());

class NewsArticleModel {
    final String? category;
    final int? datetime;
    final String? headline;
    final int? id;
    final String? image;
    final String? related;
    final String? source;
    final String? summary;
    final String? url;

    NewsArticleModel({
        this.category,
        this.datetime,
        this.headline,
        this.id,
        this.image,
        this.related,
        this.source,
        this.summary,
        this.url,
    });

    factory NewsArticleModel.fromJson(Map<String, dynamic> json) => NewsArticleModel(
        category: json["category"],
        datetime: json["datetime"],
        headline: json["headline"],
        id: json["id"],
        image: json["image"],
        related: json["related"],
        source: json["source"],
        summary: json["summary"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "datetime": datetime,
        "headline": headline,
        "id": id,
        "image": image,
        "related": related,
        "source": source,
        "summary": summary,
        "url": url,
    };
}
