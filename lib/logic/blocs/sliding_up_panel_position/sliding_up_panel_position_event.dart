abstract class SlidingUpPanelPositionEvent {}

class SlidingPanelPosition extends SlidingUpPanelPositionEvent {
  final double position;

  SlidingPanelPosition({required this.position});
}

