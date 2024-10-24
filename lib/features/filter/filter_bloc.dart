import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/filter/filter_event.dart';
import 'package:meals/features/filter/filter_state.dart';


class FiltersBloc extends Bloc<FilterEvent, FiltersState> {
  FiltersBloc() : super(const FiltersState()) {
    on<SetFilter>(_onSetFilter);

    on<SetAllFilters>(_onSetAllFilters);
  }

  void _onSetFilter(SetFilter event, Emitter<FiltersState> emit) {
      final updatedFilters = {
        ...state.filters,
        event.filter: event.isActive,
      };
      emit(state.copyWith(updatedFilters));
    }

  void _onSetAllFilters(SetAllFilters event, Emitter<FiltersState> emit) {
      emit(state.copyWith(event.filters));
    }  
}
