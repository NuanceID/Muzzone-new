abstract class InputValidatorEvent {
  const InputValidatorEvent();
}

class InputValidatorValidate extends InputValidatorEvent {
  final bool? isPhoneNumberValid;

  const InputValidatorValidate(
      {this.isPhoneNumberValid});
}
