import 'package:advanced_exchanger/src/core/presentation/screens/currency.screen.dart';
import 'package:advanced_exchanger/src/core/presentation/screens/settings.screen.dart';
import 'package:advanced_exchanger/src/core/presentation/screens/unknown.screen.dart';
import 'package:advanced_exchanger/src/core/router/route.constants.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/screens/converter.screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print("Navigating to ${settings.name}");
    switch (settings.name) {
      case RouteConstants.converterScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteConstants.converterScreen),
          builder: (context) {
            return const ConverterScreen();
          },
        );
      case RouteConstants.settingsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteConstants.settingsScreen),
          builder: (context) {
            return const SettingsScreen();
          },
        );
      case RouteConstants.currencyScreen:
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: const RouteSettings(name: RouteConstants.currencyScreen),
          builder: (context) {
            final text = settings.arguments as CurrencyScreen;
            return CurrencyScreen(
              isDefault: text.isDefault,
              currency: text.currency,
            );
          },
        );
    }

    assert(false, 'Need to implement ${settings.name}');
    return MaterialPageRoute(builder: (_) => const UnknownScreen());
  }
}

class MenuSlideUpRoute<T> extends MaterialPageRoute<T> {
  MenuSlideUpRoute(
      {required super.builder, required RouteSettings super.settings});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
