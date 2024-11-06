import 'package:equatable/equatable.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

class LoadingFilters extends FiltersEvent{}

class UpdateFilterEvent extends FiltersEvent {
  final bool? isVegan;
  final bool? isVegetarian;
  final bool? isGlutenFree;
  final bool? isLactoseFree;

  const UpdateFilterEvent({
    this.isVegan,
    this.isVegetarian,
    this.isGlutenFree,
    this.isLactoseFree,
  });
  
  @override
  List<Object?> get props => [isVegan, isVegetarian,isGlutenFree, isLactoseFree];
}

class UpdateFiltersEvent extends FiltersEvent{}

class FetchFiltersEvent extends FiltersEvent {}