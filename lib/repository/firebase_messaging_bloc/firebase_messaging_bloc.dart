import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

part 'firebase_messaging_event.dart';
part 'firebase_messaging_state.dart';

class FirebaseMessagingBloc
    extends Bloc<FirebaseMessagingEvent, FirebaseMessagingState> {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessagingBloc({@required FirebaseMessaging firebaseMessaging})
      : assert(firebaseMessaging != null),
        _firebaseMessaging = firebaseMessaging;
  @override
  FirebaseMessagingState get initialState => FirebaseMessagingInitial();

  @override
  Stream<FirebaseMessagingState> mapEventToState(
    FirebaseMessagingEvent event,
  ) async* {
    if (event is InitFirebaseNotifications) {
      yield* _mapInitFirebaseNotificationsState();
    }
  }

  Stream<FirebaseMessagingState> _mapInitFirebaseNotificationsState() async* {
    print("initfirebasenotifications");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.subscribeToTopic('notifications');
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      // setState(() {
      //   _homeScreenText = "Push Messaging token: $token";
      // });
      print(token);
    });
  }
}
