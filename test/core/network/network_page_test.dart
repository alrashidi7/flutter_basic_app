import 'package:flutter/material.dart';
import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_basic_app/core/widgets/network_offline_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_basic_app/injection_container.dart' as di;

void main() {
  Future<NetworkState> arrangeNetworkCheckIsOnline() async {
    Future.delayed(const Duration(seconds: 1));
    return InternetConnectionConnected(showConnected: false);
  }

  setUpAll(() async {
    await di.init();
    di.sl<NetworkCubit>().testNetworkOffline();
  });


  Widget createWidgetUnderTest(bool connected) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          if (connected) {
            return di.sl<NetworkCubit>()..monitorInternetConnection();
          } else {
            return di.sl<NetworkCubit>()..testNetworkOffline();
          }
        })
      ],
      child: const MaterialApp(
        home: NetworkCheckWidget(
          child: Scaffold(
            body: Center(
                child: Text(
              'check network online',
              key: Key('device_online'),
            )),
          ),
        ),
      ),
    );
  }

  // testWidgets('check network online is diplayed', (widgetTester) async {
  //   await arrangeNetworkCheckIsOnline();
  //   await widgetTester.pumpWidget(createWidgetUnderTest(true));
  //   await widgetTester.pump(const Duration(milliseconds: 100));
  //   expect(find.byKey(const Key('device_online')), findsOneWidget);
  //   await widgetTester.pumpAndSettle(const Duration(seconds: 2));
  // });

  testWidgets('check network offline is displayed', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(false));
    await widgetTester.pump(const Duration(milliseconds: 100));
    expect(find.byKey(const Key('device_offline')), findsOneWidget);
    await widgetTester.pumpAndSettle(const Duration(seconds: 4));
  });
}
