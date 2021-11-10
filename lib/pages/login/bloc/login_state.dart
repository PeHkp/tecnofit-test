class LoginState {
  final String? email;
  final String? password;
  LoginState({this.email, this.password});

  LoginState copyWith({String? email, String? password}) {
    return LoginState(
        email: email ?? this.email, password: password ?? this.password);
  }
}

class LoadingState extends LoginState {
  LoadingState({String? email, String? password})
      : super(email: email, password: password);
}

class ErrorState extends LoginState {
  final String? errorMessage;

  ErrorState({String? email, String? password, this.errorMessage})
      : super(email: email, password: password);
}

class SuccessState extends LoginState {
  final String? successMessage;

  SuccessState({String? email, String? password, this.successMessage})
      : super(email: email, password: password);
}
