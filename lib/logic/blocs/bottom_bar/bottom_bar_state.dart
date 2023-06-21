part of 'bottom_bar_bloc.dart';

class BottomBarState {
  final int activeIndex;
  final bool canUse;
  final bool visible;
  final double height;

  BottomBarState({
    required this.activeIndex,
    required this.canUse,
    this.visible = false,
    required this.height,
  });

  BottomBarState copyWith({
    int? activeIndex,
    bool? canUse,
    bool? visible,
    double? height,
  }) {
    return BottomBarState(
      activeIndex: activeIndex ?? this.activeIndex,
      canUse: canUse ?? this.canUse,
      visible: visible ?? this.visible,
      height: height ?? this.height,
    );
  }
}

class BottomBarInitial extends BottomBarState {
  BottomBarInitial({
    required super.activeIndex,
    required super.canUse,
    required super.height,
  });
}
