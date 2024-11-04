import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals_fb_bloc/bloc/favorite/favorite_event.dart';
import 'package:meals_fb_bloc/bloc/favorite/favorite_state.dart';
import 'package:meals_fb_bloc/models/meal.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final favoriteMeals = await fetchFavoriteMeals();
      print('Fetcj favorite: $favoriteMeals');
      emit(FavoriteLoadedState(favoriteMeals));
    } catch (e) {
      print('Eroare $e');
      emit(FavoriteErrorState('Failed to load favorite meals: $e'));
    }
  }


  Future<void> _onAddFavorite(AddFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (state is FavoriteLoadedState) {
      //final currentState = state as FavoriteLoadedState;
      //final updatedFavoriteMeals = List<Meal>.from(currentState.favoriteMeals);

      try {
        await addMealToFavorites(event.mealId);

        final newFavoriteMeals = await fetchFavoriteMeals();
        emit(FavoriteLoadedState(newFavoriteMeals));
      } catch (e) {
        emit(FavoriteErrorState('Failed to add favorite meal: $e'));
      }
    }
  }


  Future<void> _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (state is FavoriteLoadedState) {
      try {
        await deleteMealFromFavorites(event.mealId);

        // După ștergere, reîncărcăm lista
        final updatedFavoriteMeals = await fetchFavoriteMeals();
        emit(FavoriteLoadedState(updatedFavoriteMeals));
      } catch (e) {
        emit(FavoriteErrorState('Failed to remove favorite meal: $e'));
      }
    }
  }

  Future<List<Meal>> fetchFavoriteMeals() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference favoritesCollection = firestore.collection('favorites');
  final CollectionReference mealsCollection = firestore.collection('meals');

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

    print('Number of favorite meals fetched: ${favoriteMeals.length}');
    return favoriteMeals;
  } catch (e) {
    print('Failed to fetch favorite meals: $e');
    return [];
  }
}

Future<void> addMealToFavorites(String mealId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference favoritesCollection = firestore.collection('favorites');

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