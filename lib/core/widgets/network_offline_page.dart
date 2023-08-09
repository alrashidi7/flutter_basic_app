import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/cubit/network_cubit.dart';

class NetworkCheckWidget extends StatelessWidget {
  const NetworkCheckWidget({super.key, required this.child});
  final Scaffold child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        // var cubit = BlocProvider.of<NetworkCubit>(context);
        print('helllo ${(state is InternetConnectionDisconnected)}');
        if (state is InternetConnectionDisconnected) {
          return const Scaffold(
            body: Center(
                child: Text(
              'ooops, you are offline now',
              key: Key('device_offline'),
            )),
          );
        }
        return child;
      },
    );
  }
}
