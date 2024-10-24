import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/features/categories/categories_event.dart';
import 'package:meals/features/categories/categories_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<LoadCategories>(_onLoadCategories);
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) {
      emit(const CategoryState(categories: availableCategories));
    }
}
