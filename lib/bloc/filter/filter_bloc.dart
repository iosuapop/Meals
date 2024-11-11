import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal/bloc/filter/filter_event.dart';
import 'package:meal/bloc/filter/filter_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final FirebaseFirestore firestore;
  final CollectionReference filtersCollection;

  FiltersBloc(this.firestore)
      : filtersCollection = firestore.collection('filters'),
        super(const FiltersState()) {
    on<FetchFiltersEvent>(_onFetchFilters);
    on<UpdateFilterEvent>(_onUpdateFilter);
    on<UpdateFiltersEvent>(_onUpdateFilters);
  }

  Future<void> _onFetchFilters(
      FetchFiltersEvent event, Emitter<FiltersState> emit) async {
    emit(state.copyWith(status: FiltersStatus.loading));
    try {
      final filters = await fetchFiltersFromDatabase();
      emit(state.copyWith(
        status: FiltersStatus.loaded,
        isVegan: filters[Filter.vegan] ?? false,
        isVegetarian: filters[Filter.vegetarian] ?? false,
        isGlutenFree: filters[Filter.glutenFree] ?? false,
        isLactoseFree: filters[Filter.lactoseFree] ?? false,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: FiltersStatus.error,
          errorMessage: 'Failed to fetch filters: $e'));
    }
  }

  void _onUpdateFilter(
      UpdateFilterEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(
      isVegan: event.isVegan ?? state.isVegan,
      isVegetarian: event.isVegetarian ?? state.isVegetarian,
      isGlutenFree: event.isGlutenFree ?? state.isGlutenFree,
      isLactoseFree: event.isLactoseFree ?? state.isLactoseFree,
    ));
  }

  Future<void> _onUpdateFilters(UpdateFiltersEvent event, Emitter<FiltersState> emit) async {
    final previousState = state;
    emit(state.copyWith(status: FiltersStatus.loading));

    try {
      await modifyFiltersInDatabase({
        Filter.vegan: state.isVegan,
        Filter.vegetarian: state.isVegetarian,
        Filter.glutenFree: state.isGlutenFree,
        Filter.lactoseFree: state.isLactoseFree,
      });
      emit(state.copyWith(status: FiltersStatus.loaded));
    } catch (e) {
      emit(previousState.copyWith(
          status: FiltersStatus.error,
          errorMessage: 'Failed to update filters: $e'));
    }
  }

  Future<Map<Filter, bool>> fetchFiltersFromDatabase() async {
    final QuerySnapshot snapshot = await filtersCollection.get();

    Map<Filter, bool> filters = {};
    for (var doc in snapshot.docs) {
      final filterName = doc['name'] as String;
      final filterValue = doc['value'] as bool;

      final filterEnum = Filter.values.firstWhere(
        (e) => e.toString().split('.').last == filterName,
        orElse: () => Filter.lactoseFree,
      );
      filters[filterEnum] = filterValue;
    }
    return filters;
  }

  Future<void> modifyFiltersInDatabase(Map<Filter, bool> filters) async {
    for (var entry in filters.entries) {
      final filterName = entry.key.toString().split('.').last;
      final filterValue = entry.value;

      await filtersCollection.doc(filterName).update({
        'value': filterValue,
      }).catchError((error) {
        throw Exception('Failed to update filter: $error');
      });
    }
  }
}

enum Filter { vegan, vegetarian, glutenFree, lactoseFree }
