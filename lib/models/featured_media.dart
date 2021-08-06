class FeaturedMedia {
  FeaturedMedia({
    required this.medium,
    required this.thumbnail,
  });

  final String medium;
  final String thumbnail;

  factory FeaturedMedia.fromJson(Map<String, dynamic> json) => FeaturedMedia(
        medium:
            json['media_details']['sizes']['medium']['source_url'] as String,
        thumbnail:
            json['media_details']['sizes']['thumbnail']['source_url'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
