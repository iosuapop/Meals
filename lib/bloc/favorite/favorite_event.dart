import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final String mealId;

  const AddFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String mealId;

  const RemoveFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}
