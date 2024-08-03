import 'package:advanced_exchanger/src/core/presentation/base.view.dart';
import 'package:advanced_exchanger/src/core/providers/currency.provider.dart';
import 'package:advanced_exchanger/src/core/router/route.constants.dart';
import 'package:advanced_exchanger/src/core/router/route.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/provider/converter.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdvancedExchanger extends StatefulWidget {
  const AdvancedExchanger({Key? key}) : super(key: key);

  @override
  _AdvancedExchangerState createState() => _AdvancedExchangerState();
}

class _AdvancedExchangerState extends State<AdvancedExchanger> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BaseView<CurrencyProvider>(
        onModelReady: (model) => model.setCurrency(context),
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Advanced Exchanger',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xff181818),
              appBarTheme: const AppBarTheme(
                color: Color(0xff181818),
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 16,
                ),
                bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.white,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            initialRoute: RouteConstants.converterScreen,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        });
  }
}
