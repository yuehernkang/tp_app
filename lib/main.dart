import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_delegate.dart';
import 'home_page/home_page.dart';
import 'repository/UserRepository.dart';
import 'repository/bloc/authentication_bloc.dart';
import 'route_generator.dart';
import 'ui/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
      // BlocProvider(
      //   create: (BuildContext context) =>
      //       AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      //   child: MyApp(userRepository: userRepository),
      // ),
      MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final _router = AppRouter();

    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => buildTheme(brightness),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Temasek Polytechnic',
          theme: theme,
          navigatorObservers: <NavigatorObserver>[observer],
          onGenerateRoute: _router.generateRoute,
        );
      },
    );
  }
}
