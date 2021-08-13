import 'package:hive_flutter/adapters.dart';
import 'package:noobs2pro_app/models/media.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? link;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? content;
  @HiveField(5)
  String? shortContent;
  @HiveField(6)
  String? category;
  @HiveField(7)
  Media? featuredMedia;

  Article({
    this.id,
    this.date,
    this.link,
    this.title,
    this.content,
    this.shortContent,
    this.category,
    this.featuredMedia,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    date = json['date'] as String;
    link = json['link'] as String;
    title = json['title']['rendered'] as String;
    content = json['content']['rendered'] as String;
    shortContent = json['excerpt']['rendered'] as String;
    featuredMedia = Media.fromJson(
        json['_embedded']['wp:featuredmedia'][0] as Map<String, dynamic>);
    category = json['_embedded']['wp:term'][0][0]['name'] as String;
  }
}
