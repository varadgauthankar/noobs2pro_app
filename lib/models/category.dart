class Category {
  String? name;

  Category({
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
