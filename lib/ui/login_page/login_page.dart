import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_auth_buttons/src/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_app/ui/login_page/bloc/login_bloc.dart';
import '../../home_page/home_page.dart';

import '../../repository/UserRepository.dart';
import '../../repository/authentication_bloc/authentication_bloc.dart';
import 'bloc/login_event.dart';
import 'login_with_password.dart';
import 'bloc/login_state.dart';
import 'login_with_password_page.dart';

class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({Key key, this.userRepository});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = LoginBloc(userRepository: UserRepository());
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider(
        create: (context) => _loginBloc,
        child: BlocListener(
          bloc: _loginBloc,
          listener: (BuildContext context, LoginState state) {
            if (state.isFailure) {
              print("fail");
              // Scaffold.of(context).showSnackBar(SnackBar(
              //   content: Text("Hello"),
              // ));
            }
            if (state.isSubmitting) {
              print("submitting");
              // Flushbar(
              //   message: "Submitting",
              //   duration: Duration(seconds: 2),
              // )..show(context);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Logging in"),
              ));
            }
            if (state.isSuccess) {
              _authenticationBloc.add(LoggedIn());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<AuthenticationBloc>(context),
                            child: MyHomePage(),
                          )));
            }
          },
          child: Scaffold(
              body: Center(
            child: Container(
              constraints: BoxConstraints(minWidth: 200, maxWidth: 320),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset(
                          'assets/tplogo.png',
                          // width: 60,
                          height: 80,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: GoogleSignInButton(
                      onPressed: () {
                        _loginBloc.add(LoginWithGooglePressed());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FacebookSignInButton(
                      onPressed: () {
                        // loginBloc..add(LoginWithFacebookPressed());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: StretchableButton(
                      buttonColor: Color(0xFFFFFFFF),
                      borderRadius: 0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (context) => BlocProvider.value(
                                //       value:
                                //           BlocProvider.of<AuthenticationBloc>(
                                //               context),
                                //       child: LoginWithPasswordScreen(userRepository: UserRepository(),),
                                //     )
                                builder: (context) =>
                                    MultiBlocProvider(providers: [
                                      BlocProvider.value(
                                          value: BlocProvider.of<
                                              AuthenticationBloc>(context)),
                                      BlocProvider.value(
                                          value: _loginBloc)
                                    ], child: LoginWithPasswordScreen(userRepository: UserRepository()))));
                      },
                      buttonPadding: 8.0,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 10.0),
                          child: Text(
                            "Login with Password",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
