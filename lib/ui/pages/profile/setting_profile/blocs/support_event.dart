part of 'support_bloc.dart';

@immutable
abstract class SupportEvent {}

class OpenSupportEvent extends SupportEvent {}

class CloseSupportEvent extends SupportEvent {}
