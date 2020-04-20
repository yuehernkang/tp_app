import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password});

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  List<Object> get props => [];
}

class LoginWithFacebookPressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password});

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [];
}
