import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecnofit_test/pages/login/bloc/login_event.dart';
import 'package:tecnofit_test/pages/login/bloc/login_state.dart';
import 'package:tecnofit_test/services/login_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc({required this.loginService}) : super(LoginState()) {
    on<UpdateEmailEvent>((event, emit) => _setEmailvalue(event, emit));
    on<UpdatePasswordEvent>((event, emit) => _setPasswordvalue(event, emit));
    on<SubmitLoginEvent>((event, emit) => _submitLoginForm(event, emit));
  }
  void _setEmailvalue(UpdateEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _setPasswordvalue(UpdatePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _submitLoginForm(
      SubmitLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState(
      email: state.email,
      password: state.password,
    ));
    try {
      String message = await loginService.login(
          email: state.email, password: state.password);

      emit(SuccessState(
          email: state.email,
          password: state.password,
          successMessage: message));
    } catch (e) {
      emit(ErrorState(
          email: state.email,
          password: state.password,
          errorMessage: e.toString()));
    }
  }
}
