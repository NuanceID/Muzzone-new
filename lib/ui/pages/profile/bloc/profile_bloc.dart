import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';
import 'package:muzzone/data/models/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

final LocalDataStore _store = LocalDataStore();

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(
          ProfileInitial(
            name: Hive.box<User>('userBox').get('user')?.name ?? '',
            phoneNumber:
                Hive.box<User>('userBox').get('user')?.phoneNumber ?? '',
            registerDate: DateTime.parse(
                Hive.box<User>('userBox').get('user')?.registerDate ??
                    '1970-01-01 00:00:00'),
            nameController: TextEditingController(
              text: Hive.box<User>('userBox').get('user')?.phoneNumber ?? '',
            ),
            phoneController: TextEditingController(
              text: Hive.box<User>('userBox').get('user')?.phoneNumber ?? '',
            ),
          ),
        ) {
    on<ProfileSetNewNameEvent>(_onProfileSetNewName);
    on<ProfileEditUsernameFieldEvent>(_onEditUsernameField);
    on<ProfileEditPhoneFieldEvent>(_onEditPhoneField);
    on<ProfileCompleteEditionEvent>(_onCompleteEdition);
    on<CompleteNameField>(_onCompleteNameField);
    on<CompletePhoneField>(_onCompletePhoneField);
    on<SetTempName>(_onSetTempName);
    on<SetTempPhoto>(_onSetTempPhoto);
    on<SaveEdition>(_onSaveEdition);
    on<CancelEdition>(_onCancelEdition);
  }

  FutureOr<void> _onProfileSetNewName(
      ProfileSetNewNameEvent event, Emitter<ProfileState> emit) {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(state.copyWith(name: event.newName));
    _store.setUserName(event.newName);
  }

  FutureOr<void> _onEditUsernameField(
      ProfileEditUsernameFieldEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activeFieldName: true));
  }

  FutureOr<void> _onEditPhoneField(
      ProfileEditPhoneFieldEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activePhoneName: true));
  }

  FutureOr<void> _onCompleteEdition(
      ProfileCompleteEditionEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activeFieldName: false, activePhoneName: false));
  }

  FutureOr<void> _onCompleteNameField(
      CompleteNameField event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activePhoneName: event.active));
  }

  FutureOr<void> _onCompletePhoneField(
      CompletePhoneField event, Emitter<ProfileState> emit) {
    emit(state.copyWith(activeFieldName: event.active));
  }

  FutureOr<void> _onSetTempName(SetTempName event, Emitter<ProfileState> emit) {
    emit(state.copyWith(tempName: event.tempName));
  }

  FutureOr<void> _onSetTempPhoto(
      SetTempPhoto event, Emitter<ProfileState> emit) {
    emit(state.copyWith(tempPhoto: event.tempPhoto));
  }

  FutureOr<void> _onSaveEdition(SaveEdition event, Emitter<ProfileState> emit) {
    if (state.tempName != state.name) {
      emit(state.copyWith(name: state.tempName));
      _store.setUserName(state.tempName!);
    }
  }

  FutureOr<void> _onCancelEdition(
      CancelEdition event, Emitter<ProfileState> emit) {
    if (state.nameController.text != state.name) {
      state.nameController = TextEditingController(text: state.name);
    }
  }
}
