part of 'support_bloc.dart';

class SupportState {
  final bool isOpen;

  SupportState({this.isOpen = false});

  SupportState copyWith({required bool isOpen}) {
    return SupportState(isOpen: isOpen);
  }
}

class SupportInitial extends SupportState {
  SupportInitial({super.isOpen = false});
}
