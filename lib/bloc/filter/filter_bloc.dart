import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_fb_bloc/bloc/filter/filter_event.dart';
import 'package:meals_fb_bloc/bloc/filter/filter_state.dart';

enum Filter { vegan, vegetarian, glutenFree, lactoseFree }

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(const FiltersInitialState()) {
    on<FetchFiltersEvent>(_onFetchFilters);
    on<UpdateFiltersEvent>(_onUpdateFilters);
  }

  void _onFetchFilters(
      FetchFiltersEvent event, Emitter<FiltersState> emit) async {
    try {
      final filters = await fetchFiltersFromDatabase();
      print('Fintre fetch: $filters');
      emit(FiltersUpdatedState(
        isVegan: filters[Filter.vegan] ?? false,
        isVegetarian: filters[Filter.vegetarian] ?? false,
        isGlutenFree: filters[Filter.glutenFree] ?? false,
        isLactoseFree: filters[Filter.lactoseFree] ?? false,
      ));
    } catch (e) {
      print('Error fetching filters from database: $e');
      emit(FiltersErrorState(errorMessage: 'Failed to fetch filters: $e'));
    }
  }

  void _onUpdateFilters(
      UpdateFiltersEvent event, Emitter<FiltersState> emit) async {
    final newState = FiltersUpdatedState(
      isVegan: event.isVegan ?? state.isVegan,
      isVegetarian: event.isVegetarian ?? state.isVegetarian,
      isGlutenFree: event.isGlutenFree ?? state.isGlutenFree,
      isLactoseFree: event.isLactoseFree ?? state.isLactoseFree,
    );

    try {
      await modifyFiltersInDatabase({
        Filter.vegan: newState.isVegan,
        Filter.vegetarian: newState.isVegetarian,
        Filter.glutenFree: newState.isGlutenFree,
        Filter.lactoseFree: newState.isLactoseFree,
      });
      emit(newState);

    } catch (e) {
      print('Error fetching filters from database: $e');
      emit(FiltersErrorState(errorMessage: 'Failed to update filters: $e'));
    }
  }

  Future<Map<Filter, bool>> fetchFiltersFromDatabase() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference filtersCollection =
        firestore.collection('filters');

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
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference filtersCollection =
        firestore.collection('filters');

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
