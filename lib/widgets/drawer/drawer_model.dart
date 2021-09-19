class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  // as of now categories are hard coded
  // TODO: fetch categories from api

  static List<Category> categories = [
    Category(
      name: 'Best Of',
      id: 333, // wordpress category id
    ),
    Category(
      name: 'Best Settings Guide',
      id: 332,
    ),
    Category(
      name: 'E-sport',
      id: 4930,
    ),
    Category(
      name: 'Featured',
      id: 334,
    ),
    Category(
      name: 'Game Reviews',
      id: 13,
    ),
    Category(
      name: 'Game play Guides',
      id: 83,
    ),
    Category(
      name: 'How To Guides',
      id: 336,
    ),
    Category(
      name: 'Mobile E-sports',
      id: 5939,
    ),
    Category(
      name: 'Mobile Games',
      id: 5941,
    ),
    Category(
      name: 'Android And IOS',
      id: 2652,
    ),
  ];
}
