import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_event.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final BackendRepository _backendRepository;

  AuthorizationBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const AuthorizationState()) {
    on<Login>(_login);
  }

  _login(Login event, Emitter<AuthorizationState> emitter) async {
    emitter(state.copyWith(authorizationStatus: AuthorizationStatus.loading));

    var loginResult = await _backendRepository.postLogin(event.phoneNumber);

    if (loginResult is NetworkStateSuccess) {
      var loginData = loginResult.data?.data as Map<String, dynamic>;

      if (loginData['message'] == authCodeSentSuccessfully) {
        return emitter(state.copyWith(
            authorizationStatus: AuthorizationStatus.success,
            phoneNumber: event.phoneNumber,
            serverMessage: authCodeSentSuccessfully));
      }

      if (loginData['message'] == phoneNumberNotFound) {
        return emitter(state.copyWith(
            authorizationStatus: AuthorizationStatus.success,
            phoneNumber: event.phoneNumber,
            serverMessage: phoneNumberNotFound));
      }

      if (loginData['message'] == authCodeWrong) {
        return emitter(state.copyWith(
            authorizationStatus: AuthorizationStatus.success,
            phoneNumber: event.phoneNumber,
            serverMessage: authCodeWrong));
      }

      return emitter(
          state.copyWith(authorizationStatus: AuthorizationStatus.failure));
    }

    if (loginResult is NetworkStateFailed) {
      return emitter(
          state.copyWith(authorizationStatus: AuthorizationStatus.failure));
    }
  }
}
