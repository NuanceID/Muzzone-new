import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_event.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_state.dart';

class PhoneNumberVerificationBloc
    extends Bloc<PhoneNumberVerificationEvent, PhoneNumberVerificationState> {
  final BackendRepository _backendRepository;

  PhoneNumberVerificationBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const PhoneNumberVerificationState()) {
    on<PhoneNumberVerified>(_phoneNumberVerified);
  }

  _phoneNumberVerified(PhoneNumberVerified event,
      Emitter<PhoneNumberVerificationState> emitter) async {
    emitter(state.copyWith(
        phoneNumberVerificationStatus: PhoneNumberVerificationStatus.loading));

    var loginResult = await _backendRepository.postSmsCheck(
        event.phoneNumber, '0' /*event.authCode*/);

    if (loginResult is NetworkStateSuccess) {
      var loginData = loginResult.data?.data as Map<String, dynamic>;

      if (loginData.containsKey('token')) {
        var userData = User(
            phoneNumber: event.phoneNumber,
            token: loginData['token'] as String,
            name: 'Пользователь',
            registerDate: DateTime.now().toUtc().toString());

        await Hive.box<User>('userBox').clear();

        await Hive.box<User>('userBox').put('user', userData);

        return emitter(state.copyWith(
            phoneNumberVerificationStatus:
            PhoneNumberVerificationStatus.success,
            serverMessage: token));
      }

      if (loginData['message'] == authCodeWrong) {
        return emitter(state.copyWith(
            phoneNumberVerificationStatus:
            PhoneNumberVerificationStatus.success,
            serverMessage: authCodeWrong));
      }

      return emitter(state.copyWith(
          phoneNumberVerificationStatus:
          PhoneNumberVerificationStatus.failure));
    }

    if (loginResult is NetworkStateFailed) {
      return emitter(state.copyWith(
          phoneNumberVerificationStatus:
          PhoneNumberVerificationStatus.failure));
    }
  }
}
