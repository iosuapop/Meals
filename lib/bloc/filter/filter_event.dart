import 'package:equatable/equatable.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

class UpdateFiltersEvent extends FiltersEvent {
  final bool? isVegan;
  final bool? isVegetarian;
  final bool? isGlutenFree;
  final bool? isLactoseFree;

  const UpdateFiltersEvent({
    this.isVegan,
    this.isVegetarian,
    this.isGlutenFree,
    this.isLactoseFree,
  });

  @override
  List<Object?> get props => [isVegan, isVegetarian, isGlutenFree, isLactoseFree];
}

class FetchFiltersEvent extends FiltersEvent {}
