import 'package:flutter/material.dart';
import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_basic_app/core/widgets/network_offline_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_basic_app/injection_container.dart' as di;

void main() {
  late NetworkCubit networkCubit;
  late bool diInitialized = false;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!diInitialized) {
      await di.init();
      diInitialized = true;
    }
    networkCubit = di.sl<NetworkCubit>();
  });

  arrangeTestWidget() {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => networkCubit)],
      child: MaterialApp(
        home: BlocBuilder<NetworkCubit, NetworkState>(
          builder: (context, state) {
            return const NetworkCheckWidget(
                child: Scaffold(
              body: Center(
                child: Text(
                  'device online',
                  key: Key('device_online'),
                ),
              ),
            ));
          },
        ),
      ),
    );
  }

  testWidgets('network cubit shoud diplay child when call test online network',
      (widgetTester) async {
    await networkCubit.testNetworkOnline();
    await widgetTester.pumpWidget(arrangeTestWidget());
    await widgetTester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const Key('device_online')), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });

  testWidgets(
      'network cubit shoud diplay offline child when call test offline network',
      (widgetTester) async {
    await networkCubit.testNetworkOffline();
    await widgetTester.pumpWidget(arrangeTestWidget());
    await widgetTester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const Key('device_offline')), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });
}
