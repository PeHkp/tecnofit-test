import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecnofit_test/config/config.dart';
import 'package:tecnofit_test/pages/home/home_page.dart';
import 'package:tecnofit_test/pages/login/bloc/login_bloc.dart';
import 'package:tecnofit_test/pages/login/login_page.dart';
import 'package:tecnofit_test/services/login_service.dart';
import 'package:tecnofit_test/services/repository/login_repository.dart';

void main() {
  LoginRepository loginRepository = LoginRepository(
      dio: Dio(BaseOptions(baseUrl: Config.URLVALUE, headers: {
    "Content-Type": "application/json",
  })));
  LoginService(loginRepository: loginRepository);
  runApp(MyApp(
    loginService: LoginService.instance,
  ));
}

class MyApp extends StatelessWidget {
  final LoginService loginService;
  const MyApp({Key? key, required this.loginService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tecnofit Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/login": (_) => LoginPage(),
          "/home": (_) => const HomePage()
        },
        home: BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(loginService: loginService),
            child: LoginPage()));
  }
}
