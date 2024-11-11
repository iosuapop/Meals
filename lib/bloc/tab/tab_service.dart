import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/category.dart';
import 'package:meal/models/meal.dart';

class TabService {
  final FirebaseFirestore firestore;

  const TabService(this.firestore);

  Future<List<Meal>> fetchMeals() async {
    try {
      final querySnapshot = await firestore.collection('meals').get();
      return querySnapshot.docs
          .map((doc) => Meal.fromMap(doc.data()))
          .toList();
    } catch (error) {
      throw Exception("Failed to fetch meals: $error");
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final querySnapshot = await firestore.collection('categories').get();
      return querySnapshot.docs
          .map((doc) => Category.fromFirestore(doc))
          .toList();
    } catch (error) {
      throw Exception("Error fetching categories: $error");
    }
  }
}
