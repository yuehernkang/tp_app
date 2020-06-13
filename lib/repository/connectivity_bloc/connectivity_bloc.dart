import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:tp_app/services/connectivity_service.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  @override
  ConnectivityState get initialState => ConnectivityInitial();

  @override
  Stream<ConnectivityState> mapEventToState(
    ConnectivityEvent event,
  ) async* {
    if (event is InitConnectivity) {
      yield* _mapInitConnectivityToState();
    }
  }

  Stream<ConnectivityState> _mapInitConnectivityToState() async* {
    developer.log('wtf', name: 'connectivityBloc');
  }
}
