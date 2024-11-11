import 'package:equatable/equatable.dart';
import 'package:meal/bloc/tab/tab_bloc.dart';
import 'package:meal/models/meal.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends TabEvent {}

class ChangePageIndexEvent extends TabEvent {
  final int newIndex;

  const ChangePageIndexEvent(this.newIndex);
}

class UpdateFilteredMealsEvent extends TabEvent {
  final Map<Filter, bool> filters;
  final List<Meal> meals;

  const UpdateFilteredMealsEvent({required this.filters, required this.meals});
}

class FilterMealsByCategoryEvent extends TabEvent {
  final String categoryId;

  const FilterMealsByCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
