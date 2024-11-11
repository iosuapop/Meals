import 'package:equatable/equatable.dart';

enum FiltersStatus { initial, loading, loaded, error }

class FiltersState extends Equatable {
  final FiltersStatus status;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final String? errorMessage;

  const FiltersState({
    this.status = FiltersStatus.initial,
    this.isVegan = false,
    this.isVegetarian = false,
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.errorMessage,
  });

  FiltersState copyWith({
    FiltersStatus? status,
    bool? isVegan,
    bool? isVegetarian,
    bool? isGlutenFree,
    bool? isLactoseFree,
    String? errorMessage,
  }) {
    return FiltersState(
      status: status ?? this.status,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isVegan, isVegetarian, isGlutenFree, isLactoseFree, errorMessage];
}
