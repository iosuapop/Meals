import 'package:equatable/equatable.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
  }

  class LoadCategoriesEvent extends CategoriesEvent {
  final List<Meal> availableMeals;
  final Function(Meal meal) ontoggleFavorite;
  final List<Category> availableCategories;

  const LoadCategoriesEvent({
    required this.availableMeals,
    required this.availableCategories,
    required this.ontoggleFavorite,
  });

  @override
  List<Object?> get props => [availableMeals, availableCategories, ontoggleFavorite];
}

  class SelectCategoryEvent extends CategoriesEvent {
    final Category category;

    const SelectCategoryEvent(this.category);

    @override
    List<Object?> get props => [category];
}

  class ToggleFavoriteMealEvent extends CategoriesEvent {
    final Meal meal;

    const ToggleFavoriteMealEvent(this.meal);

    @override
    List<Object?> get props => [meal];
}
