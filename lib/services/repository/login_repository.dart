import 'package:dio/dio.dart';
import 'package:tecnofit_test/services/login_exeption.dart';

class LoginRepository {
  final Dio dio;

  LoginRepository({required this.dio});

  errorHandler(error) {
    throw LoginException.fromMap(error);
  }

  Future<dynamic?> login({
    required String email,
    required String password,
  }) async {
    try {
      Response<dynamic> response =
          await dio.post('${dio.options.baseUrl}api/login',
              options: Options(
                headers: dio.options.headers,
              ),
              data: {
            'email': email,
            'password': password,
          });
      return response.data['token'];
    } on DioError catch (e) {
      return errorHandler(e);
    }
  }
}
