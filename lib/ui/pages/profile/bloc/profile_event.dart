part of 'profile_bloc.dart';

class ProfileEvent {}

class ProfileSetNewNameEvent extends ProfileEvent {
  final String newName;

  ProfileSetNewNameEvent({required this.newName});
}

class ProfileEditUsernameFieldEvent extends ProfileEvent {}

class ProfileEditPhoneFieldEvent extends ProfileEvent {}

class CompleteNameField extends ProfileEvent {
  final bool active = false;
}

class CompletePhoneField extends ProfileEvent {
  final bool active = false;
}

class ProfileCompleteEditionEvent extends ProfileEvent {}

class SetTempName extends ProfileEvent {
  final String tempName;

  SetTempName({required this.tempName});
}

class SetTempPhoto extends ProfileEvent {
  final String tempPhoto;

  SetTempPhoto({required this.tempPhoto});
}

class SaveEdition extends ProfileEvent {}

class CancelEdition extends ProfileEvent {}
