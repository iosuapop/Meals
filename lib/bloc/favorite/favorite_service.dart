import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/meal.dart';

class FavoriteService {
  final FirebaseFirestore firestore;

  FavoriteService(this.firestore);

  Future<List<Meal>> fetchFavoriteMeals() async {
    try {
      final QuerySnapshot favoritesSnapshot = await firestore.collection('favorites').get();
      List<String> favoriteMealIds = favoritesSnapshot.docs.map((doc) => doc['mealId'] as String).toList();

      if (favoriteMealIds.isEmpty) {
        return [];
      }

      List<Meal> favoriteMeals = [];
      for (String mealId in favoriteMealIds) {
        final DocumentSnapshot mealSnapshot = await firestore.collection('meals').doc(mealId).get();
        if (mealSnapshot.exists) {
          favoriteMeals.add(Meal.fromMap(mealSnapshot.data() as Map<String, dynamic>));
        }
      }
      return favoriteMeals;

    } catch (e) {
      throw Exception('Failed to fetch favorite meals');
    }
  }

  Future<void> addMealToFavorites(String mealId) async {
    try {
      await firestore.collection('favorites').add({'mealId': mealId});
    } catch (e) {
      throw Exception('Failed to add meal to favorites');
    }
  }

  Future<void> deleteMealFromFavorites(String mealId) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('favorites').where('mealId', isEqualTo: mealId).get();
      for (var doc in snapshot.docs) {
        await firestore.collection('favorites').doc(doc.id).delete();
      }
    } catch (e) {
      throw Exception('Failed to remove meal from favorites');
    }
  }
}
