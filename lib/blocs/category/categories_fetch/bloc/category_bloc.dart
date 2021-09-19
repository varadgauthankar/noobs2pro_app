import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/category/categories_fetch/repository/category_repository.dart';
import 'package:noobs2pro_app/widgets/drawer/drawer_model.dart';

part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;

  CategoryBloc(this._repository) : super(CategoryStateInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is GetCategoriesEvent) {
      yield CategoryStateLoading();

      try {
        final List<Category> categories = await _repository.getCategories();
        print(categories);
        yield CategoryStateComplete(categories);
      } catch (e) {
        yield CategoryStateError(e.toString());
      }
    }
  }
}
