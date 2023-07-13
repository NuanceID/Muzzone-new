import 'package:equatable/equatable.dart';

class InputValidatorState extends Equatable {
  final bool isPhoneNumberValid;

  const InputValidatorState({
    this.isPhoneNumberValid = false,
  });

  @override
  List<Object> get props => [isPhoneNumberValid];

  InputValidatorState copyWith({
    bool? isPhoneNumberValid,
  }) {
    return InputValidatorState(
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
    );
  }
}
