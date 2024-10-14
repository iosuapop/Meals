import 'package:equatable/equatable.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final List<Category> availableCategories;
  
  const CategoriesLoadedState(this.availableCategories);

  @override
  List<Object?> get props => [availableCategories];
}

class MealsLoadedState extends CategoriesState{
  final String categoryTitle;
  final List<Meal> filteredMeals;

  const MealsLoadedState(this.categoryTitle, this.filteredMeals);

  @override
  List<Object?> get props => [categoryTitle, filteredMeals];
}