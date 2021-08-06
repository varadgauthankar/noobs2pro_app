class Article {
  int? id;
  String? date;
  String? dateGmt;
  String? link;
  String? title;
  String? content;
  String? excerpt;
  int? featuredMedia;
  List<int>? categories;

  Article({
    this.id,
    this.date,
    this.dateGmt,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.featuredMedia,
    this.categories,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    date = json['date'] as String;
    dateGmt = json['date_gmt'] as String;
    link = json['link'] as String;
    title = json['title']['rendered'] as String;
    content = json['content']['rendered'] as String;
    excerpt = json['excerpt']['rendered'] as String;
    categories = json['categories'].cast<int>() as List<int>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['date'] = date;
    data['date_gmt'] = dateGmt;
    data['link'] = link;
    data['title'] = title;
    data['content'] = content;
    data['excerpt'] = excerpt;
    data['featured_media'] = featuredMedia;
    data['categories'] = categories;

    return data;
  }
}