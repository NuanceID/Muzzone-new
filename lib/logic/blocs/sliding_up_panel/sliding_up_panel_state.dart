import 'package:equatable/equatable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelState extends Equatable {
  final PanelController panelController;
  final double maxHeight;
  final double minHeight;
  final bool isOpenSlidingUpPanel;

  const SlidingUpPanelState({
    required this.panelController,
    this.maxHeight = 0.0,
    this.minHeight = 0.0,
    this.isOpenSlidingUpPanel = false,
  });

  @override
  List<Object> get props => [
        panelController,
        maxHeight,
        minHeight,
        isOpenSlidingUpPanel
      ];

  SlidingUpPanelState copyWith(
      {double? maxHeight,
      double? minHeight,
      bool? isOpenSlidingUpPanel}) {
    return SlidingUpPanelState(
        panelController: panelController,
        maxHeight: maxHeight ?? this.maxHeight,
        minHeight: minHeight ?? this.minHeight,
        isOpenSlidingUpPanel: isOpenSlidingUpPanel ?? this.isOpenSlidingUpPanel);
  }
}

