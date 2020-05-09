import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_auth_buttons/src/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_app/ui/login_page/login_with_password.dart';

import '../../repository/UserRepository.dart';
import '../../repository/bloc/authentication_bloc.dart';

class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({Key key, this.loginBloc, this.userRepository});

  final AuthenticationBloc loginBloc;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'assets/ic_launcher.png',
                    width: 60,
                    height: 60,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Sign in to TTTTTTTT',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GoogleSignInButton(
                onPressed: () {
                  // loginBloc..add(LoginWithGooglePressed());
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
                                builder: (context) => BlocProvider.value(
                                      value: BlocProvider.of<AuthenticationBloc>(context),
                                      child: LoginWithPassword(),
                                    )));
                },
                buttonPadding: 8.0,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 10.0),
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
    ));
  }
}
