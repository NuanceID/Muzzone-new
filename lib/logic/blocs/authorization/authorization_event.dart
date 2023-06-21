abstract class AuthorizationEvent {
  const AuthorizationEvent();
}

class Login extends AuthorizationEvent {
  final String phoneNumber;

  const Login({required this.phoneNumber});
}
