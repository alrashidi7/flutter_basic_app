import 'package:dio/dio.dart';
import 'package:flutter_basic_app/core/api/api_consumer.dart';
import 'package:flutter_basic_app/core/api/dio_provider.dart';
import 'package:flutter_basic_app/core/network/cubit/network_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //core

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  sl.registerFactory<NetworkCubit>(() => NetworkCubit(connectionChecker: sl()));
//external

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final secureDatabaseLocal =
      FlutterSecureStorage(aOptions: getAndroidOptions());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => secureDatabaseLocal);
}
