import 'dart:async';
import 'package:bloc_connectivity/packages/network/network_event.dart';
import 'package:bloc_connectivity/packages/network/network_state.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc({this.subscription}) : super(ConnectionInitial());

  StreamSubscription? subscription;

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is ListenConnection) {
      subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
