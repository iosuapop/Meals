import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals/bloc/filter/filter_bloc.dart';
import 'package:meals/bloc/filter/filter_state.dart';
import 'package:meals/bloc/tab/tab_event.dart';
import 'package:meals/bloc/tab/tab_state.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

final mealsCollection = FirebaseFirestore.instance.collection('meals');
final categoryCollection = FirebaseFirestore.instance.collection('categories');

class TabBloc extends Bloc<TabEvent, TabState> {
  final FiltersBloc filtersBloc;
  late StreamSubscription<FiltersState> filtersSubscription;

  TabBloc(this.filtersBloc) : super(TabInitialState()) {
    on<FetchDataEvent>(_onFetchData);
    on<ChangePageIndexEvent>(_onChangePageIndex);
    on<FilterMealsByCategoryEvent>(_onFilterMealsByCategory);
    on<UpdateFilteredMealsEvent>(_onUpdateFilteredMeals);
  }

  @override
  Future<void> close() {
    filtersSubscription.cancel();
    return super.close();
  }

  Future<void> _onFetchData(
      FetchDataEvent event, Emitter<TabState> emit) async {
    emit(TabLoadingState());

    try {
      final List<Meal>? meals = await fetchMealsFromDatabase();
      final List<Category>? categories = await fetchCategories();
      if (meals == null || categories == null) {
        emit(const TabErrorState('Eroare la incarcarea informatiilor.'));
      } else {
        emit(
            TabLoadedState(categories: categories, meals: meals, indexPage: 0));
      }

      filtersSubscription = filtersBloc.stream.listen((filtersState) {
        if (state is TabLoadedState) {
          final filters = {
            Filter.glutenFree: filtersState.isGlutenFree,
            Filter.lactoseFree: filtersState.isLactoseFree,
            Filter.vegetarian: filtersState.isVegetarian,
            Filter.vegan: filtersState.isVegan,
          };

          add(UpdateFilteredMealsEvent(
              filters: filters, meals: (state as TabLoadedState).meals));
        }
      });
    } catch (e) {
      emit(TabErrorState('Failed to fetch data: $e'));
    }
  }

  void _onUpdateFilteredMeals(
      UpdateFilteredMealsEvent event, Emitter<TabState> emit) async {
    if (state is TabLoadedState) {
      final currentState = state as TabLoadedState;
      final filteredMeals = await applyFilters(event.meals, event.filters);

      emit(TabLoadedState(
        categories: currentState.categories,
        meals: filteredMeals,
        indexPage: currentState.indexPage,
      ));
    }
  }

  void _onChangePageIndex(ChangePageIndexEvent event, Emitter<TabState> emit) {
    if (state is TabLoadedState) {
      final currentState = state as TabLoadedState;
      emit(TabLoadedState(
        categories: currentState.categories,
        meals: currentState.meals,
        indexPage: event.newIndex,
      ));
    }
  }

  Future<List<Meal>?> fetchMealsFromDatabase() async {
    List<Meal> mealsList = [];
    try {
      QuerySnapshot querySnapshot = await mealsCollection.get();
      for (var doc in querySnapshot.docs) {
        mealsList.add(Meal.fromMap(doc.data() as Map<String, dynamic>));
      }
      return mealsList;
    } catch (error) {
      print("Failed to fetch meals: $error");
      emit(const TabErrorState('Eroare la incarcarea meals'));
    }

    return null;
  }

  Future<List<Category>?> fetchCategories() async {
    try {
      final querySnapshot = await categoryCollection.get();
      final categoryList =
          querySnapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
      return categoryList;
    } catch (e) {
      print('eroare la preluarea categoriilor');
      return null;
    }
  }

  Future<List<Meal>> applyFilters(
      List<Meal> meals, Map<Filter, bool> filters) async {
    final mealsList = await fetchMealsFromDatabase();
    if (mealsList != null) {
      return mealsList.where((meal) {
        bool matches = true;
        print(
            'filtru : ${filters[Filter.vegan]} mancare cu filtru: meal.isVegan ${meal.isVegan}');
        if (filters[Filter.vegan] == true && !meal.isVegan) {
          matches = false;
        }
        if (filters[Filter.vegetarian] == true && !meal.isVegetarian) {
          matches = false;
        }
        if (filters[Filter.glutenFree] == true && !meal.isGlutenFree) {
          matches = false;
        }
        if (filters[Filter.lactoseFree] == true && !meal.isLactoseFree) {
          matches = false;
        }

        return matches;
      }).toList();
    } else {
      throw new Exception('Eroare in aplicarea filtrelor');
    }
  }

  Future<void> _onFilterMealsByCategory(
      FilterMealsByCategoryEvent event, Emitter<TabState> emit) async {
    if (state is TabLoadedState) {
      final currentState = state as TabLoadedState;
      final filtersState = filtersBloc.state;

      if (filtersState is FiltersUpdatedState) {
        final currentFilters = {
          Filter.glutenFree: filtersState.isGlutenFree,
          Filter.lactoseFree: filtersState.isLactoseFree,
          Filter.vegetarian: filtersState.isVegetarian,
          Filter.vegan: filtersState.isVegan,
        };

        final onlyMeals = await fetchMealsFromDatabase();
        if (onlyMeals != null) {
          final List<Meal> filteredMeals =
              await applyFilters(onlyMeals, currentFilters);

          final List<Meal> finalMeals = filteredMeals
              .where((meal) => meal.categories.contains(event.categoryId))
              .toList();

          emit(TabLoadedState(
            categories: currentState.categories,
            meals: finalMeals,
            indexPage: currentState.indexPage,
          ));
        } else {
          emit(const TabErrorState('Eroare la selectarea categoriei.'));
        }
      }
    }
  }
}
