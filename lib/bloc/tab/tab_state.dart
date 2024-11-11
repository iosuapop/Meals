import 'package:equatable/equatable.dart';
import 'package:meal/models/category.dart';
import 'package:meal/models/meal.dart';


abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object?> get props => [];
}

class TabInitialState extends TabState {}

class TabLoadingState extends TabState {}

class TabLoadedState extends TabState {
  final List<Category> categories;
  final String? currentCategoryId;
  final List<Meal> meals;
  final int indexPage;

  const TabLoadedState({
    required this.categories,
    this.currentCategoryId,
    required this.meals,
    required this.indexPage,
  });

  TabLoadedState copyWith({
    List<Category>? categories,
    String? currentCategoryId,
    List<Meal>? meals,
    int? indexPage,
  }) {
    return TabLoadedState(
      categories: categories ?? this.categories,
      currentCategoryId: currentCategoryId ?? this.currentCategoryId,
      meals: meals ?? this.meals,
      indexPage: indexPage ?? this.indexPage,
    );
  }

  @override
  List<Object?> get props => [categories, currentCategoryId, meals, indexPage];
}

class TabErrorState extends TabState {
  final String errorMessage;

  const TabErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
