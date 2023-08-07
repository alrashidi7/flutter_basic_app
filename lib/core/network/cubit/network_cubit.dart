import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final InternetConnectionChecker connectionChecker;
  NetworkCubit({required this.connectionChecker}) : super(NetworkInitial()) {
    if ((Platform.isAndroid || Platform.isIOS) && !kIsWeb) {
      monitorInternetConnection();
    }
  }

  // ignore: cancel_subscriptions
  StreamSubscription? internetConnectionStreamSubscription;
  bool showConnected = false;

  void monitorInternetConnection() async {
    internetConnectionStreamSubscription =
        connectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(InternetConnectionConnected(showConnected: showConnected));
          showConnected = false;
          break;
        case InternetConnectionStatus.disconnected:
          showConnected = true;
          emit(InternetConnectionDisconnected());
          break;
      }
    });
  }

  @override
  Future<void> close() async {
    internetConnectionStreamSubscription!.cancel();
    return super.close();
  }
}
