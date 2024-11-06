import 'package:equatable/equatable.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';


abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object?> get props => [];
}

class TabInitialState extends TabState {}

class TabLoadingState extends TabState {}

class TabLoadedState extends TabState {
  final List<Category> categories;
  final List<Meal> meals;
  final int indexPage;

  const TabLoadedState({
    required this.categories,
    required this.meals,
    required this.indexPage,
  });
}

class TabErrorState extends TabState {
  final String errorMessage;

  const TabErrorState(this.errorMessage);
}
