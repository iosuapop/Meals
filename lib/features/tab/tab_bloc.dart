import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_event.dart';
import 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState>{
  TabBloc() : super(const TabState(selectedIndex: 0)) {
    on<TabChanged>((event, emit) {
      emit(TabState(selectedIndex: event.tabIndex));
    });
  }
}