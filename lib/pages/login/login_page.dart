import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecnofit_test/pages/login/bloc/login_bloc.dart';
import 'package:tecnofit_test/pages/login/bloc/login_event.dart';
import 'package:tecnofit_test/pages/login/bloc/login_state.dart';
import 'package:tecnofit_test/widgets/text_input_widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailFieldController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController passwordFieldController = TextEditingController();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          switch (state.runtimeType) {
            case ErrorState:
              ErrorState errorState = state as ErrorState;
              Fluttertoast.showToast(
                  msg: errorState.errorMessage ?? "Error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.grey[900],
                  textColor: Colors.white,
                  fontSize: 16.0);
              break;
            case SuccessState:
              SuccessState successState = state as SuccessState;
              Fluttertoast.showToast(
                  msg: successState.successMessage ?? "Success",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.grey[900],
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushReplacementNamed(context, '/home');
              break;
            default:
          }
        }, builder: (context, state) {
          switch (state.runtimeType) {
            case ErrorState:
            case SuccessState:
            case LoadingState:
            case LoginState:
              return Padding(
                padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/logo.jpg',
                            width: 150,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextInputWidget(
                            label: 'E-mail',
                            keyboardType: TextInputType.emailAddress,
                            enabled: state is! LoadingState,
                            onChanged: (value) => {
                              context
                                  .read<LoginBloc>()
                                  .add(UpdateEmailEvent(email: value))
                            },
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            controller: emailFieldController,
                            icon: const Icon(Icons.person,
                                color: Colors.blueAccent),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextInputWidget(
                            label: 'Senha',
                            keyboardType: TextInputType.text,
                            enabled: state is! LoadingState,
                            onChanged: (value) => {
                              context
                                  .read<LoginBloc>()
                                  .add(UpdatePasswordEvent(password: value))
                            },
                            autofocus: false,
                            textInputAction: TextInputAction.done,
                            controller: passwordFieldController,
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              side: const BorderSide(
                                                  color: Colors.transparent))),
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              vertical: 19, horizontal: 82)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blueAccent)),
                                  onPressed: () => {
                                    if (loginFormKey.currentState!.validate())
                                      {
                                        context
                                            .read<LoginBloc>()
                                            .add(SubmitLoginEvent())
                                      }
                                  },
                                  child: state is LoadingState
                                      ? const SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.lightBlue,
                                              )))
                                      : Text(
                                          'Entrar',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => {},
                                child: Text(
                                  'Esqueci a senha',
                                  style: GoogleFonts.roboto(
                                      color: Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
