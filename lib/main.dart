import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './constants.dart';

import 'bloc/bloc_delegate.dart';
import 'repository/UserRepository.dart';
import 'repository/authentication_bloc/authentication_bloc.dart';
import 'repository/connectivity_bloc/connectivity_bloc.dart';
import 'repository/firebase_messaging_bloc/firebase_messaging_bloc.dart';
import 'route_generator.dart';
import 'ui/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<FirebaseMessagingBloc>(create: (BuildContext context) {
        return FirebaseMessagingBloc(firebaseMessaging: firebaseMessaging)
          ..add(InitFirebaseNotifications());
      }),
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
        },
      ),
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) {
          return ConnectivityBloc()..add(InitConnectivity());
        },
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _router = AppRouter(context, _authenticationBloc);
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => buildTheme(brightness),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Temasek Polytechnic',
          theme: theme,
          navigatorObservers: <NavigatorObserver>[MyApp.observer],
          onGenerateRoute: _router.generateRoute,
          onUnknownRoute: (RouteSettings setting) {
            String unknownRoute = setting.name;
            // return new MaterialPageRoute(builder: (context) => NotFoundPage());
          },
        );
      },
    );
  }
}
