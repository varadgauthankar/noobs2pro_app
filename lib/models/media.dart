class Media {
  String? medium;
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
