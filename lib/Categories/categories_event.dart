import 'package:mealss/models/category.dart';
import 'package:mealss/screens/filters.dart';

// Definirea evenimentelor
abstract class CategoriesEvent {}

class SelectCategoryEvent extends CategoriesEvent {
  final Category category;
  SelectCategoryEvent(this.category);
}

class LoadCategoriesEvent extends CategoriesEvent{
  LoadCategoriesEvent();
}

class ResetCategoriesEvent extends CategoriesEvent {}

class UpdateFiltersEvent extends CategoriesEvent {
  final Map<Filter, bool> filters;
  UpdateFiltersEvent(this.filters);
}
