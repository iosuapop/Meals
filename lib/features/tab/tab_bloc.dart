import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/tab/tab_event.dart';
import 'package:meals/features/tab/tab_state.dart';


class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState()) {
    on<TabChanged>(_onTabChanged);
  }
  void _onTabChanged(TabChanged event, Emitter<TabState> emit) {
    emit(TabState(selectedTabIndex: event.tabIndex));
  }
}
