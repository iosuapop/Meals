import 'package:meals/features/filter/filter_state.dart';
import 'package:meals/models/meal.dart';

class FilteredMealsState{
  final List<Meal> filteredMeals;
  final Map<Filter, bool> filters;

  const FilteredMealsState({
    this.filteredMeals = const [],
    this.filters = const {
      Filter.glutenFree: false,
      Filter.lactoseFree: false,
      Filter.vegetarian: false,
      Filter.vegan: false,
    },
  });


  List<Object> get props => [filteredMeals, filters];
}
