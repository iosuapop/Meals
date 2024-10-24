abstract class TabEvent {}

class TabChanged extends TabEvent {
  final int tabIndex;

  TabChanged(this.tabIndex);
}
