import 'package:equatable/equatable.dart';
import 'package:meals/screens/filters.dart';

abstract class FilterEvent extends Equatable{
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class UpdateFilters extends FilterEvent{
  final Map<Filter, bool> filters;

  UpdateFilters(this.filters);

  @override
  List<Object?> get props => [filters];
}