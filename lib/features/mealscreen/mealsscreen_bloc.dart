import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/mealscreen/mealsscreen_event.dart';
import 'package:meals/features/mealscreen/mealsscreen_state.dart';

class MealsScreenBloc extends Bloc<MealsScreenEvent, MealsScreenState> {
  MealsScreenBloc() : super(const MealsScreenState(meals: [])) {
    on<LoadMeals>(_onLoadMeals);

    on<LoadFavorites>(_onLoadFavorites);
  }

  void _onLoadMeals(LoadMeals event, Emitter<MealsScreenState> emit) {
      emit(MealsScreenState(title: event.title, category: event.category, meals: event.meals.where((meal) => meal.categories.contains(event.category.id)).toList()));
    }
  
  void _onLoadFavorites(LoadFavorites event, Emitter<MealsScreenState> emit) {
      emit(MealsScreenState(meals: event.meals));
    }
}
