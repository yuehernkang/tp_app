part of 'firebase_messaging_bloc.dart';

abstract class FirebaseMessagingEvent extends Equatable {
  const FirebaseMessagingEvent();
  List<Object> get props => null;
}

class InitFirebaseNotifications extends FirebaseMessagingEvent {}
