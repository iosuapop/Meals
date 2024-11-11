import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/filter/filter_bloc.dart';
import 'package:meal/bloc/filter/filter_state.dart';
import 'package:meal/bloc/tab/tab_event.dart';
import 'package:meal/bloc/tab/tab_state.dart';
import 'package:meal/models/category.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/bloc/tab/tab_service.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class TabBloc extends Bloc<TabEvent, TabState> {
  final FiltersBloc filtersBloc;
  final TabService tabService;
  late StreamSubscription<FiltersState> filtersSubscription;

  TabBloc(this.filtersBloc, this.tabService) : super(TabInitialState()) {
    on<FetchDataEvent>(_onFetchData);
    on<ChangePageIndexEvent>(_onChangePageIndex);
    on<FilterMealsByCategoryEvent>(_onFilterMealsByCategory);
    on<UpdateFilteredMealsEvent>(_onUpdateFilteredMeals);

    filtersSubscription = filtersBloc.stream.listen((filtersState) {
      if (state is TabLoadedState) {
        final currentState = state as TabLoadedState;
        final filters = {
          Filter.glutenFree: filtersState.isGlutenFree,
          Filter.lactoseFree: filtersState.isLactoseFree,
          Filter.vegetarian: filtersState.isVegetarian,
          Filter.vegan: filtersState.isVegan,
        };

        add(UpdateFilteredMealsEvent(
          filters: filters,
          meals: currentState.meals,
        ));
      }
    });
  }

  Future<void> _onFetchData(FetchDataEvent event, Emitter<TabState> emit) async {
    emit(TabLoadingState());

    try {
      final List<Meal> meals = await tabService.fetchMeals();
      final List<Category> categories = await tabService.fetchCategories();

      emit(TabLoadedState(categories: categories, meals: meals, indexPage: 0));
    } catch (e) {
      emit(TabErrorState('Eroare la încărcarea informațiilor: $e'));
    }
  }

  void _onUpdateFilteredMeals(UpdateFilteredMealsEvent event, Emitter<TabState> emit) async {
    
    if (state is TabLoadedState) {
      final currentState = state as TabLoadedState;
      final filteredMeals = await applyFilters(event.meals, event.filters);
      emit(currentState.copyWith(meals: filteredMeals));
    }
  }

  void _onChangePageIndex(ChangePageIndexEvent event, Emitter<TabState> emit) {
    if (state is TabLoadedState) {
      final currentState = state as TabLoadedState;
      emit(currentState.copyWith(indexPage: event.newIndex));
    }
  }

  Future<List<Meal>> applyFilters(List<Meal> meals, Map<Filter, bool> filters) async {
    final mealsList = await tabService.fetchMeals();
    return mealsList.where((meal) {
      bool matches = true;

      if (filters[Filter.vegan] == true && !meal.isVegan) matches = false;
      if (filters[Filter.vegetarian] == true && !meal.isVegetarian) matches = false;
      if (filters[Filter.glutenFree] == true && !meal.isGlutenFree) matches = false;
      if (filters[Filter.lactoseFree] == true && !meal.isLactoseFree) matches = false;

      return matches;
    }).toList();
  }

  Future<void> _onFilterMealsByCategory(
      FilterMealsByCategoryEvent event, Emitter<TabState> emit) async {
    if (state is TabLoadedState) {
      
      final currentState = state as TabLoadedState;
      var filtersState = filtersBloc.state;
      emit(TabLoadingState());

      if (filtersState.status == FiltersStatus.loaded) {
        final currentFilters = {
          Filter.glutenFree: filtersState.isGlutenFree,
          Filter.lactoseFree: filtersState.isLactoseFree,
          Filter.vegetarian: filtersState.isVegetarian,
          Filter.vegan: filtersState.isVegan,
        };

        final onlyMeals = await tabService.fetchMeals();
        final List<Meal> filteredMeals = await applyFilters(onlyMeals, currentFilters);

        final List<Meal> finalMeals = filteredMeals
            .where((meal) => meal.categories.contains(event.categoryId))
            .toList();

        emit(currentState.copyWith(meals: finalMeals));
      } else {
        print('eroare filtre to category');
        emit(const TabErrorState('Eroare la selectarea categoriei.'));
      }
    }
  }

  @override
  Future<void> close() {
    filtersSubscription.cancel();
    return super.close();
  }
}
