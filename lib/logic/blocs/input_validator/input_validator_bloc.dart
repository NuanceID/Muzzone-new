import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_event.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_state.dart';


class InputValidatorBloc
    extends Bloc<InputValidatorEvent, InputValidatorState> {
  InputValidatorBloc() : super(const InputValidatorState()) {
    on<InputValidatorValidate>(_validate);
  }

  _validate(InputValidatorValidate event,
      Emitter<InputValidatorState> emitter) async {
    return emitter(state.copyWith(
        isPhoneNumberValid: event.isPhoneNumberValid ?? state.isPhoneNumberValid,));
  }
}
