part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
  List<Object> get props => null;
}

class InitConnectivity extends ConnectivityEvent {}

class NoConnection extends ConnectivityEvent {}

class ConnectionDetected extends ConnectivityEvent {}

