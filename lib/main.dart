import 'dart:async';

import 'package:advanced_exchanger/src/app.dart';
import 'package:advanced_exchanger/src/core/presentation/screens/system_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/feature/converter/presentation/provider/converter.provider.dart';
import 'src/injection_container.dart' as di;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    ErrorWidget.builder = (errorDetails) => const CustomSystemErrorScreen();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ConverterProvider>(
              create: (_) => ConverterProvider()),
        ],
        child: const AdvancedExchanger(),
      ),
    );
  }, (error, stack) => print(error));
}
