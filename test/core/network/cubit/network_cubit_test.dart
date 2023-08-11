import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_basic_app/injection_container.dart' as di;

void main() {
  late NetworkCubit networkCubit;
  late bool diInitialized = false;

  setUp(() async {
    if (!diInitialized) {
      await di.init();
    }
    diInitialized = true;
    networkCubit =
        NetworkCubit(connectionChecker: di.sl<InternetConnectionChecker>());
  });

  test(
      'network cubit shoud emit network online state when call text online network',
      () async {
    //arrange
    final expectedState = InternetConnectionConnected(showConnected: false);

    //assert
    expectLater(networkCubit.stream, emits(isA<InternetConnectionConnected>()));

    //act
    await networkCubit.testNetworkOnline();
  });

  test(
      'network cubti shoud emit network offline state when call test online network',
      () async {
    //arrrange
    final expectedState = InternetConnectionDisconnected();

    //assert
    expectLater(
        networkCubit.stream, emits(isA<InternetConnectionDisconnected>()));

    //act
    await networkCubit.testNetworkOffline();
  });
}
