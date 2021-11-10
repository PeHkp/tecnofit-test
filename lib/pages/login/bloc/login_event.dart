class LoginEvent {}

class UpdateEmailEvent extends LoginEvent {
  String email;

  UpdateEmailEvent({required this.email});
}

class UpdatePasswordEvent extends LoginEvent {
  String password;

  UpdatePasswordEvent({required this.password});
}

class SubmitLoginEvent extends LoginEvent {}
