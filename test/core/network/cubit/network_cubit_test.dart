import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

void main() {
  late InternetConnectionChecker checker;

  setUp(() {
    checker = InternetConnectionChecker.createInstance();
  });

  Future<InternetConnectionStatus> arrangeNetworkCheckIsOnline() async {
    Future.delayed(const Duration(seconds: 1));
    return InternetConnectionStatus.connected;
  }

  Future<InternetConnectionStatus> arrangeNetworkCheckIsOffline() async {
    Future.delayed(const Duration(seconds: 1));
    return InternetConnectionStatus.disconnected;
  }

  test('check network shoud be online', () async {
    //arrange
    const matcher = InternetConnectionStatus.connected;
    //act
    final result = await arrangeNetworkCheckIsOnline();
    // assert
    expect(result, matcher);
  });

  test('check network shoud be offline', () async {
    // arrange
    const matcher = InternetConnectionStatus.disconnected;

    // act
    final result = await arrangeNetworkCheckIsOffline();

    //assert

    expect(result, matcher);
  });
}
