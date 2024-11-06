import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoriteEvent {}

class ModifyFavoriteEvent extends FavoriteEvent {
  final String mealId;

  const ModifyFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}
