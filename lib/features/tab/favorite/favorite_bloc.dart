import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/models/meal.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Meal> _favoriteMeals = [];

  FavoriteBloc() : super(FavoriteInitialState()) {
    on<ToggleFavoriteMeal>((event, emit) {
      final isFavorite = _favoriteMeals.contains((event.meal));
      if(isFavorite){
        _favoriteMeals.remove(event.meal);
      }
      else {
        _favoriteMeals.add(event.meal);
      }

      emit(FavoriteUpdateState(List.from(_favoriteMeals)));
    });
  }

  List<Meal> get favoriteMeals => _favoriteMeals;
}