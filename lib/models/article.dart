import 'package:noobs2pro_app/models/media.dart';

class Article {
  int? id;
  String? date;
  String? link;
  String? title;
  String? content;
  String? shortContent;
  String? category;
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
