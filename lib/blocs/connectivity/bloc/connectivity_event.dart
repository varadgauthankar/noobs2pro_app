part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class ListenConnection extends ConnectivityEvent {}

class ConnectionChanged extends ConnectivityEvent {
  final ConnectivityState connectivityState;
  ConnectionChanged(this.connectivityState);
}
