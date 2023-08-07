import 'package:flutter/material.dart';
import 'package:flutter_basic_app/app.dart';
import 'injection_container.dart' as dependancyInjection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependancyInjection.init();
  runApp(const AppName());
}
