abstract class PhoneNumberVerificationEvent {
  const PhoneNumberVerificationEvent();
}

class PhoneNumberVerified extends PhoneNumberVerificationEvent {
  final String phoneNumber;
  final String authCode;

  const PhoneNumberVerified(
      {required this.phoneNumber, required this.authCode});
}
