part of 'bottom_bar_bloc.dart';

@immutable
abstract class BottomBarEvent {}

class ChangeBottomBarItemEvent extends BottomBarEvent {
  final int newActiveIndex;

  ChangeBottomBarItemEvent(this.newActiveIndex);
}

class HideBottomBar extends BottomBarEvent {}

class ShowBottomBar extends BottomBarEvent {}

class ChangeHeightBottomBar extends BottomBarEvent {
  final double newHeight;

  ChangeHeightBottomBar({required this.newHeight});
}
