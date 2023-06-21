enum AuthorizationStatus { initial, success, failure, loading }

class AuthorizationState {
  final AuthorizationStatus authorizationStatus;
  final String phoneNumber;
  final String serverMessage;

  const AuthorizationState(
      {this.authorizationStatus = AuthorizationStatus.initial,
      this.phoneNumber = '',
      this.serverMessage = ''});

  AuthorizationState copyWith(
      {AuthorizationStatus? authorizationStatus,
      String? phoneNumber,
      String? serverMessage}) {
    return AuthorizationState(
        authorizationStatus: authorizationStatus ?? this.authorizationStatus,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        serverMessage: serverMessage ?? this.serverMessage);
  }
}
