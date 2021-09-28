import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial());
  StreamSubscription? _streamSubscription;
  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ListenConnection) {
      _streamSubscription =
          Connectivity().onConnectivityChanged.listen((event) {
        add(
          ConnectionChanged(
            event == ConnectivityResult.none
                ? ConnectivityOffline()
                : ConnectivityOnline(),
          ),
        );
      });
    }

    if (event is ConnectionChanged) {
      yield event.connectivityState;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
