import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/tab/tab_event.dart';
import 'package:meals/features/tab/tab_state.dart';


class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState()) {
    on<TabChanged>((event, emit) {
      emit(TabState(selectedTabIndex: event.tabIndex));
    });
  }
}
