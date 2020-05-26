import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:tp_app/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

import '../../../repository/UserRepository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  // @override
  // Stream<Transition<LoginEvent, LoginState>> transformEvents(
  //     Stream<LoginEvent> events, transitionFn) {
  //   final nonDebounceStream = events.where((event) {
  //     return (event is! EmailChanged && event is! PasswordChanged);
  //   });
  //   final debounceStream = events.where((event) {
  //     return (event is EmailChanged || event is PasswordChanged);
  //   }).debounceTime(Duration(milliseconds: 300));
  //   return super.transformEvents(
  //     nonDebounceStream.mergeWith([debounceStream]),
  //     transitionFn,
  //   );
  // }
  
   @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    final defferedEvents = events
        .where((e) => e is EmailChanged || e is PasswordChanged)
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .switchMap(transitionFn);
    final forwardedEvents = events
        .where((e) => e is! EmailChanged && e is! PasswordChanged)
        .asyncExpand(transitionFn);
    return forwardedEvents.mergeWith([defferedEvents]);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      print(event.toString());
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    yield LoginState.loading();
    print("not yet implement");
    // TODO: implement facebook login?
    // await this.userRepository.signInWithFacebook();
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle().then((FirebaseUser user) {
        print(user);
      }).catchError((e) {
        print(e);
      });
      yield LoginState.success();
    } on PlatformException catch (e) {
      yield LoginState.failure();
      print(e.message);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
