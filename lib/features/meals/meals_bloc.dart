import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/features/meals/meals_event.dart';
import 'package:meals/features/meals/meals_state.dart';


class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(const MealState()) {
    on<LoadDish>(_onLoadDish);
  }

  void _onLoadDish(LoadDish event, Emitter<MealState> emit) {
      emit(const MealState(meals: dummyMeals));
    }
}
