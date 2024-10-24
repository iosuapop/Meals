import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/favorite/favorite_event.dart';
import 'package:meals/features/favorite/favorite_state.dart';
import 'package:meals/models/meal.dart';


class FavoriteMealsBloc extends Bloc<FavoriteMealEvent, FavoriteMealsState> {
  FavoriteMealsBloc() : super(const FavoriteMealsState()){
    on<ToggleFavoriteMeal>(_onToggleFavoriteMeal);
  }

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.favoriteMeals.contains(meal);

    if (isFavorite) {
      final updatedMeals = state.favoriteMeals.where((m) => m.id != meal.id).toList();
      emit(FavoriteMealsState(favoriteMeals: updatedMeals));
    } else {
      final updatedMeals = [...state.favoriteMeals, meal];
      emit(FavoriteMealsState(favoriteMeals: updatedMeals));
    }

    return !isFavorite;
  }

  void _onToggleFavoriteMeal(ToggleFavoriteMeal event, Emitter<FavoriteMealsState> emit) {
    toggleMealFavoriteStatus(event.meal);
  }
}
