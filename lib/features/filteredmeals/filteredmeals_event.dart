import 'package:meals/features/filter/filter_state.dart';
import 'package:meals/models/meal.dart';

abstract class FilteredMealsEvent{
  const FilteredMealsEvent();

  List<Object> get props => [];
}

class UpdateMeals extends FilteredMealsEvent {
  final List<Meal> meals;

  const UpdateMeals(this.meals);

  @override
  List<Object> get props => [meals];
}

class UpdateFilters extends FilteredMealsEvent {
  final Map<Filter, bool> filters;

  const UpdateFilters(this.filters);

  @override
  List<Object> get props => [filters];
}
