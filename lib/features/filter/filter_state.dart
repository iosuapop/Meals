enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersState{
  final Map<Filter, bool> filters;

  const FiltersState({this.filters = const {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  }});


  List<Object> get props => [filters];

  FiltersState copyWith(Map<Filter, bool>? filters) {
    return FiltersState(
      filters: filters ?? this.filters,
    );
  }
}
