import 'package:noobs2pro_app/blocs/category/categories_fetch/repository/category_repository.dart';
import 'package:noobs2pro_app/services/api_service.dart';
import 'package:noobs2pro_app/widgets/drawer/drawer_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    // categories = await ApiService.getAllCategories();
    // print(categories);
    return categories;
  }
}
