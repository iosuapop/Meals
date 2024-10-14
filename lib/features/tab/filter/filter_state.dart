import 'package:equatable/equatable.dart';
import 'package:meals/screens/filters.dart';

class FilterState extends Equatable{
  final Map<Filter, bool> selectedFilters;

  const FilterState({required this.selectedFilters});

  @override
  List<Object?> get props => [selectedFilters];
  }