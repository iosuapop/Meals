import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/favorite/favorite_event.dart';
import 'package:meal/bloc/favorite/favorite_service.dart';
import 'package:meal/bloc/favorite/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteService favoriteService;

  FavoriteBloc(this.favoriteService) : super(FavoriteInitialState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ModifyFavoriteEvent>(_onModifyFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final favoriteMeals = await favoriteService.fetchFavoriteMeals();
      emit(FavoriteLoadedState(favoriteMeals));
    } catch (e) {
      emit(FavoriteErrorState('Failed to load favorite meals: $e'));
      print("eroare $e");
    }
  }


  Future<void> _onModifyFavorite(ModifyFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (state is FavoriteLoadedState) {
      try {
        final currentState = state as FavoriteLoadedState;
        if(currentState.favoriteMeals.any((meal) => meal.id == event.mealId)){
          await favoriteService.deleteMealFromFavorites(event.mealId);
        }
        else{
          await favoriteService.addMealToFavorites(event.mealId);
        }
        
        final newFavoriteMeals = await favoriteService.fetchFavoriteMeals();
        emit(FavoriteLoadedState(newFavoriteMeals));
      } catch (e) {
        emit(FavoriteErrorState('Failed to modify favorite meal: $e'));
      }
    }
  }
}