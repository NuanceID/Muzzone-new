abstract class SlidingUpPanelEvent {}

class OpenMiniPlayer extends SlidingUpPanelEvent {}

class CloseMiniPlayer extends SlidingUpPanelEvent {}

class OpenSlidingPanel extends SlidingUpPanelEvent {
  OpenSlidingPanel();
}

class CloseSlidingPanel extends SlidingUpPanelEvent {
  CloseSlidingPanel();
}
