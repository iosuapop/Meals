import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/filter/filter_bloc.dart';
import 'package:meals/features/filter/filter_state.dart';
import 'package:meals/features/filteredmeals/filteredmeals_event.dart';
import 'package:meals/features/filteredmeals/filteredmeals_state.dart';
import 'package:meals/features/meals/meals_bloc.dart';
import 'package:meals/models/meal.dart';

class FilteredMealsBloc extends Bloc<FilteredMealsEvent, FilteredMealsState> {
  List<Meal> allMeals = [];
  Map<Filter, bool> currentFilters = {};

  FilteredMealsBloc({required MealBloc mealBloc, required FiltersBloc filtersBloc}) : super(const FilteredMealsState()) {

    mealBloc.stream.listen((mealState) {
      add(UpdateMeals(mealState.meals));
    });

    filtersBloc.stream.listen((filterState) {
      add(UpdateFilters(filterState.filters));
    });

    on<UpdateMeals>(_onUpdateMeals);

    on<UpdateFilters>(_onUpdateFilters);
  }

  void _applyFilters(Emitter<FilteredMealsState> emit, Map<Filter, bool> filters) {
    final filteredMeals = allMeals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    emit(FilteredMealsState(filteredMeals: filteredMeals, filters: filters));
  }

  void _onUpdateMeals(UpdateMeals event, Emitter<FilteredMealsState> emit) {
      allMeals = event.meals;
      _applyFilters(emit, state.filters);
    }

  void _onUpdateFilters(UpdateFilters event, Emitter<FilteredMealsState> emit) {
      currentFilters = event.filters;
      _applyFilters(emit, event.filters);
    }
}
