import 'filter_state.dart';

abstract class FilterEvent{
  const FilterEvent();


  List<Object> get props => [];
}

class SetFilter extends FilterEvent {
  final Filter filter;
  final bool isActive;

  const SetFilter(this.filter, this.isActive);

  @override
  List<Object> get props => [filter, isActive];
}

class SetAllFilters extends FilterEvent {
  final Map<Filter, bool> filters;

  const SetAllFilters(this.filters);

  @override
  List<Object> get props => [filters];
}
