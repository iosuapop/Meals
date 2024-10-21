import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/mealsdetails/mealsdetails_event.dart';
import 'package:meals/features/mealsdetails/mealsdetails_state.dart';
import 'package:meals/models/meal.dart';

class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  MealDetailsBloc() : super(MealDetailsState()) {
    on<LoadMealDetails>(_onLoadMealDetails);
  }

  void _onLoadMealDetails (LoadMealDetails event, Emitter<MealDetailsState> emit) {
      emit(MealDetailsState(meal: event.meal));
    }
}
