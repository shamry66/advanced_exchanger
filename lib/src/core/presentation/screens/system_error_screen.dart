import 'package:advanced_exchanger/src/core/router/route.constants.dart';
import 'package:flutter/material.dart';

class CustomSystemErrorScreen extends StatelessWidget {
  const CustomSystemErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Something went wrong, please try again!',
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteConstants.converterScreen,
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text("Go back"),
                ),
              ],
            ),
          ),
        ));
  }
}
