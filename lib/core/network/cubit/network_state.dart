part of 'network_cubit.dart';
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class InternetConnectionConnected extends NetworkState {
  final bool showConnected;

  InternetConnectionConnected({required this.showConnected});
}

class InternetConnectionDisconnected extends NetworkState {}
