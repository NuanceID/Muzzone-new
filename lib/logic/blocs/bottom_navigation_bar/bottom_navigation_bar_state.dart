import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarState extends Equatable {
  final int index;
  final TabController? tabController;

  const BottomNavigationBarState({
    this.index = 0,
    this.tabController,
  });

  @override
  List<Object> get props => [
        index,
      ];

  BottomNavigationBarState copyWith({
    int? index,
    TabController? tabController,
  }) {
    return BottomNavigationBarState(
      index: index ?? this.index,
      tabController: tabController ?? this.tabController,
    );
  }
}
