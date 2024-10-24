import 'package:meals/models/category.dart';

class CategoryState{
  final List<Category> categories;

  const CategoryState({this.categories = const []});


  List<Object> get props => [categories];
}
