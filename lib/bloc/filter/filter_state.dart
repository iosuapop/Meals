import 'package:equatable/equatable.dart';

abstract class FiltersState extends Equatable{
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;

  const FiltersState({
    this.isVegan = false,
    this.isVegetarian = false,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
  });

  @override
  List<Object> get props => [isVegan, isVegetarian, isGlutenFree, isLactoseFree];

}

class FiltersInitialState extends FiltersState {
  const FiltersInitialState({
    super.isVegan,
    super.isVegetarian,
    super.isGlutenFree,
    super.isLactoseFree,
  });
}

class FiltersUpdatedState extends FiltersState {
  const FiltersUpdatedState({
    required super.isVegan,
    required super.isVegetarian,
    required super.isGlutenFree,
    required super.isLactoseFree,
  });
}

class FiltersErrorState extends FiltersState {
  final String errorMessage;

  const FiltersErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

