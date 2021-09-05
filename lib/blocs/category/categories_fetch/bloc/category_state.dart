part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateComplete extends CategoryState {
  final List<Category> categories;
  CategoryStateComplete(this.categories);
}

class CategoryStateError extends CategoryState {
  final String error;
  CategoryStateError(this.error);
}
