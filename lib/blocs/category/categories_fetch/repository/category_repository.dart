import 'package:noobs2pro_app/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}
