import 'package:equatable/equatable.dart';

class SlidingUpPanelPositionState extends Equatable {
  final double position;

  const SlidingUpPanelPositionState({
    this.position = 0.0,
  });

  @override
  List<Object> get props => [
        position,
      ];

  SlidingUpPanelPositionState copyWith({
    double? position,
  }) {
    return SlidingUpPanelPositionState(
      position: position ?? this.position,
    );
  }
}
