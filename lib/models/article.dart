import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'article.g.dart';

Uuid uuid = Uuid();

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
  @HiveField(8)
  bool? isSaved;
  @HiveField(9)
  String? uid;

  Article({
    this.id,
    this.date,
    this.link,
    this.title,
    this.content,
    this.shortContent,
    this.category,
    this.featuredMedia,
    this.isSaved = false,
    this.uid,
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
    isSaved = false;
    uid = uuid.v4();
  }

  Article copyWith({bool isSaved = false}) {
    return Article(
      id: id,
      date: date,
      link: link,
      title: title,
      content: title,
      shortContent: shortContent,
      featuredMedia: featuredMedia,
      category: category,
      isSaved: isSaved,
      uid: uid,
    );
  }
}

@HiveType(typeId: 1)
class Media extends HiveObject {
  @HiveField(0)
  String? medium;
  @HiveField(1)
  String? thumbnail;

  Media({
    this.medium,
    this.thumbnail,
  });

  Media.fromJson(Map<String, dynamic> json) {
    medium = json['media_details']['sizes']['medium']['source_url'] as String;
    thumbnail =
        json['media_details']['sizes']['thumbnail']['source_url'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
