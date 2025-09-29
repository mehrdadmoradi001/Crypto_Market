import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'core/di/service_locator.dart';
import 'main_app.dart';

void main() async {
  AppConfig.setEnvironment(Environment.dev);

  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setup();
  runApp(const Application());
}