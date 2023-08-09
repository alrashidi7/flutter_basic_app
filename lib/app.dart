import 'package:flutter/material.dart';
import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_basic_app/core/utils/app_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_route.dart';
import 'injection_container.dart' as di;

class AppName extends StatefulWidget {
  const AppName({super.key});

  @override
  State<AppName> createState() => _AppNameState();
}

class _AppNameState extends State<AppName> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<NetworkCubit>())],
      child: MaterialApp(
        theme: AppStyle.theme,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
