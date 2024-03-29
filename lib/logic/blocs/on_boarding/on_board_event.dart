part of 'on_board_bloc.dart';

abstract class OnBoardEvent {}

class OnboardChangeEvent extends OnBoardEvent {
  final int currentPage;
  final String buttonName;

  OnboardChangeEvent({required this.currentPage, required this.buttonName});
}
