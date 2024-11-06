import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals/bloc/favorite/favorite_event.dart';
import 'package:meals/bloc/favorite/favorite_state.dart';
import 'package:meals/models/meal.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference favoritesCollection = firestore.collection('favorites');
final CollectionReference mealsCollection = firestore.collection('meals');

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ModifyFavoriteEvent>(_onModifyFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final favoriteMeals = await fetchFavoriteMeals();
      if(favoriteMeals != null){
        print('Fetch favorite: $favoriteMeals');
      emit(FavoriteLoadedState(favoriteMeals));
      }
      else{
        emit(const FavoriteErrorState("A aparut o eroare in incarcarea datelor, inccearca mai tarziu."));
      }
    } catch (e) {
      print('eroare on load');
      emit(FavoriteErrorState('Failed to load favorite meals: $e'));
    }
  }


  Future<void> _onModifyFavorite(ModifyFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (state is FavoriteLoadedState) {
      try {
        final currentState = state as FavoriteLoadedState;
        if(currentState.favoriteMeals.any((meal) => meal.id == event.mealId)){
          deleteMealFromFavorites(event.mealId);
        }
        else{
          addMealToFavorites(event.mealId);
        }
        
        final newFavoriteMeals = await fetchFavoriteMeals();
        if(newFavoriteMeals != null){
        print('Fetch favorite: $newFavoriteMeals');
      emit(FavoriteLoadedState(newFavoriteMeals));
      }
      else{
        emit(const FavoriteErrorState("A aparut o eroare la modificare, inccearca mai tarziu."));
      }
      } catch (e) {
        print('eroare on modify');
        emit(FavoriteErrorState('Failed to add favorite meal: $e'));
      }
    }
  }

  Future<List<Meal>?> fetchFavoriteMeals() async {
  try {
    final QuerySnapshot favoritesSnapshot = await favoritesCollection.get();
    List<String> favoriteMealIds = favoritesSnapshot.docs
        .map((doc) => doc['mealId'] as String)
        .toList();

    if (favoriteMealIds.isEmpty) {
      print('No favorites found');
      return [];
    }

    List<Meal> favoriteMeals = [];

    for (String mealId in favoriteMealIds) {
      final DocumentSnapshot mealSnapshot = await mealsCollection.doc(mealId).get();

      if (mealSnapshot.exists) {
        favoriteMeals.add(Meal.fromMap(mealSnapshot.data() as Map<String, dynamic>));
      }
    }
    return favoriteMeals;

  } catch (e) {
    print('eroare on fetch');
    return null;
  }
}

Future<void> addMealToFavorites(String mealId) async {
  try {
    await firestore.collection('favorites').add({
      'mealId': mealId,
    });
    print('Meal added to favorites: $mealId');
  } catch (e) {
    print('Failed to add meal to favorites: $e');
  }
}

Future<void> deleteMealFromFavorites(String mealId) async {
  try {
    QuerySnapshot snapshot = await favoritesCollection.where('mealId', isEqualTo: mealId).get();
    for (var doc in snapshot.docs) {
      await favoritesCollection.doc(doc.id).delete();
      print('Meal removed from favorites: $mealId');
    }
  } catch (e) {
    print('Failed to remove meal from favorites: $e');
  }
}
}