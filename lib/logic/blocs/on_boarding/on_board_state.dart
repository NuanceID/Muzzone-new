part of 'on_board_bloc.dart';

class OnBoardState {
  final String title;
  final int currentPage;

  OnBoardState({required this.title, this.currentPage = 0});

  OnBoardState copyWith({
    required String title,
    int? currentPage,
  }) {
    return OnBoardState(
        title: title, currentPage: currentPage ?? this.currentPage);
  }
}

class OnBoardInitial extends OnBoardState {
  OnBoardInitial({
    required super.title,
    super.currentPage,
  });
}
