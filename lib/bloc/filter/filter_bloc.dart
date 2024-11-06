import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/bloc/filter/filter_event.dart';
import 'package:meals/bloc/filter/filter_state.dart';

enum Filter { vegan, vegetarian, glutenFree, lactoseFree }

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference filtersCollection = firestore.collection('filters');

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(const FiltersInitialState()) {
    on<FetchFiltersEvent>(_onFetchFilters);
    on<UpdateFilterEvent>(_onUpdateFilter);
    on<UpdateFiltersEvent>(_onUpdateFilters);
  }

  void _onFetchFilters(
      FetchFiltersEvent event, Emitter<FiltersState> emit) async {
    try {
      final filters = await fetchFiltersFromDatabase();
      if (filters.isEmpty) {
  emit(const FiltersErrorState(errorMessage: 'No filters found in the database'));
} else {
      emit(FiltersUpdatedState(
        isVegan: filters[Filter.vegan] ?? false,
        isVegetarian: filters[Filter.vegetarian] ?? false,
        isGlutenFree: filters[Filter.glutenFree] ?? false,
        isLactoseFree: filters[Filter.lactoseFree] ?? false,
      ));
    }}catch (e) {
      print('Error fetching filters');
      emit(FiltersErrorState(errorMessage: 'Failed to fetch filters: $e'));
    }
  }

  void _onUpdateFilter(
      UpdateFilterEvent event, Emitter<FiltersState> emit) {
    emit(FiltersUpdatedState(
      isVegan: event.isVegan?? state.isVegan,
      isVegetarian: event.isVegetarian ?? state.isVegetarian,
      isGlutenFree: event.isGlutenFree ?? state.isGlutenFree,
      isLactoseFree: event.isLactoseFree ?? state.isLactoseFree,
    ));
  }

  void _onUpdateFilters(UpdateFiltersEvent event, Emitter<FiltersState> emit) async {
    try {
      await modifyFiltersInDatabase({
        Filter.vegan: state.isVegan,
        Filter.vegetarian: state.isVegetarian,
        Filter.glutenFree: state.isGlutenFree,
        Filter.lactoseFree: state.isLactoseFree,
      });
    } catch (e) {
      print('Error modifying filters');
      emit(const FiltersErrorState(errorMessage: 'Failed to update filters'));
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
        print('Failed to update filter: $error');
        throw Exception('Failed to update filter: $error');
      });
    }
  }
}
