enum PhoneNumberVerificationStatus { initial, success, failure, loading }

class PhoneNumberVerificationState {
  final PhoneNumberVerificationStatus phoneNumberVerificationStatus;
  final String serverMessage;

  const PhoneNumberVerificationState(
      {this.phoneNumberVerificationStatus =
          PhoneNumberVerificationStatus.initial,
      this.serverMessage = ''});

  PhoneNumberVerificationState copyWith(
      {PhoneNumberVerificationStatus? phoneNumberVerificationStatus,
      String? serverMessage}) {
    return PhoneNumberVerificationState(
        phoneNumberVerificationStatus:
            phoneNumberVerificationStatus ?? this.phoneNumberVerificationStatus,
        serverMessage: serverMessage ?? this.serverMessage);
  }
}
