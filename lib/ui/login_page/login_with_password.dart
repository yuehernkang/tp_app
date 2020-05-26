import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/src/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_page/home_page.dart';
import '../../repository/UserRepository.dart';
import '../../repository/authentication_bloc/authentication_bloc.dart';
import '../../utils/stateful_wrapper.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';
import 'password_field.dart';

class LoginWithPassword extends StatefulWidget {
  static const String routeName = "/loginWithPasswordPage";

  @override
  _LoginWithPasswordState createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final LoginBloc _loginBloc = LoginBloc(userRepository: UserRepository());
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return StatefulWrapper(
      onInit: () {
        _emailController.addListener(_onEmailChanged);
        _passwordController.addListener(_onPasswordChanged);
      },
      child: BlocProvider(
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
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("Logging in"),
                // ));
              }
              if (state.isSuccess) {
                _authenticationBloc.add(LoggedIn());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value:
                                  BlocProvider.of<AuthenticationBloc>(context),
                              child: MyHomePage(),
                            )));
              }
            },
            child: BlocBuilder(
              bloc: _loginBloc,
              builder: (BuildContext context, LoginState state) {
                return LoginPasswordScreen(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  passwordFieldKey: _passwordFieldKey,
                  loginBloc: BlocProvider.of<LoginBloc>(context),
                  authenticationBloc: _authenticationBloc,
                  state: state
                );
              },
            ),
          )),
    );
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }
}

class LoginPasswordScreen extends StatelessWidget {
  const LoginPasswordScreen(
      {Key key,
      @required TextEditingController emailController,
      @required TextEditingController passwordController,
      @required GlobalKey<FormFieldState<String>> passwordFieldKey,
      @required LoginBloc loginBloc,
      @required AuthenticationBloc authenticationBloc,
      LoginState state})
      : _emailController = emailController,
        _passwordController = passwordController,
        _passwordFieldKey = passwordFieldKey,
        _loginBloc = loginBloc,
        _state = state;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final GlobalKey<FormFieldState<String>> _passwordFieldKey;
  final LoginBloc _loginBloc;
  final LoginState _state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
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
                        'Temasek Polytechnic',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter your email',
                        labelText: 'Email'),
                    validator: (_) {
                      return !_state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PasswordField(
                    controller: _passwordController,
                    fieldKey: _passwordFieldKey,
                    labelText: 'Password',
                    onFieldSubmitted: (String value) {
                      // setState(() {
                      //   this._password = value;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: StretchableButton(
                    buttonColor: Color(0xFFFFFFFF),
                    borderRadius: 0,
                    onPressed: () {
                      _loginBloc.add(LoginWithCredentialsPressed(
                          email: _emailController.value.text,
                          password: _passwordController.value.text));
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
