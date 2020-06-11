part of 'firebase_messaging_bloc.dart';

abstract class FirebaseMessagingState extends Equatable {
  const FirebaseMessagingState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends FirebaseMessagingState { }

class FirebaseMessagingInitial extends FirebaseMessagingState { }
