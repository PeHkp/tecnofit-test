import 'package:localstorage/localstorage.dart';
import 'package:tecnofit_test/model/login_model.dart';
import 'package:tecnofit_test/services/repository/login_repository.dart';

class LoginService {
  static LoginService? _singleton;
  static get instance => _singleton;

  final LocalStorage storage = LocalStorage('Tectnofit_storage');

  final LoginRepository loginRepository;

  LoginService({required this.loginRepository})
      : assert(loginRepository != null) {
    if (_singleton == null) {
      _singleton = this;
    } else {
      throw Exception(
          "LoginService already created. Use LoginService.instance instead.");
    }
  }

  Future<String> login({required email, required password}) async {
    String response =
        await loginRepository.login(email: email, password: password);

    storage.setItem('token', response);

    return "Usuário logado com sucesso";
  }
}
