import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/filter/filter_event.dart';
import 'package:meals/features/filter/filter_state.dart';


class FiltersBloc extends Bloc<FilterEvent, FiltersState> {
  FiltersBloc() : super(const FiltersState()) {
    on<SetFilter>((event, emit) {
      final updatedFilters = {
        ...state.filters,
        event.filter: event.isActive,
      };
      emit(state.copyWith(updatedFilters));
    });

    on<SetAllFilters>((event, emit) {
      emit(state.copyWith(event.filters));
    });
  }
}
