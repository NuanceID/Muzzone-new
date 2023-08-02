import 'package:flutter/material.dart';

abstract class BottomNavigationBarEvent {}

class SelectedBottomNavBarItem extends BottomNavigationBarEvent {
  final int index;

  SelectedBottomNavBarItem({required this.index});
}

class SetTabController extends BottomNavigationBarEvent {
  final TabController tabController;

  SetTabController({required this.tabController});
}
