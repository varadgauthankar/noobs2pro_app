import 'package:noobs2pro_app/widgets/drawer/drawer_model.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}
