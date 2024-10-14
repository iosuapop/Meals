import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/screens/filters.dart';
import 'filter_event.dart';
import 'filter_state.dart';

const kInitialFilters= {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState(selectedFilters: kInitialFilters)) {
    on<UpdateFilters>((event, emit) {
      emit(FilterState(selectedFilters: event.filters));
    });
  }
}