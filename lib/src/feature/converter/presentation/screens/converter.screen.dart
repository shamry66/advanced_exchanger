import 'dart:convert';

import 'package:advanced_exchanger/src/core/presentation/screens/currency.screen.dart';
import 'package:advanced_exchanger/src/core/providers/currency.provider.dart';
import 'package:advanced_exchanger/src/core/router/route.constants.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/provider/converter.provider.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/widgets/currency_text_field.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool gettingExchangeRates = true;
  final TextEditingController _controller = TextEditingController();

  String getRates(String code) {
    var allRates = context.watch<ConverterProvider>().exchangeRate;
    var defVal = context.watch<ConverterProvider>().value;
    var rate = allRates.singleWhereOrNull((v) => v.code == code);
    if (rate != null && rate.value != null) {
      var amount = rate.value! * defVal;
      return amount == 0 ? '0' : amount.toStringAsFixed(4);
    } else {
      return '0';
    }
  }

  Future<void> fetchExchangeRates() async {
    gettingExchangeRates = true;
    setState(() {});
    if (!mounted) return;
    return await context
        .read<CurrencyProvider>()
        .getExchangeRate(
          context,
          GetExchangeRateRequest(
            currencies: context.read<CurrencyProvider>().selectedCurrencies,
            baseCurrency:
                context.read<CurrencyProvider>().defaultCurrency?.code ?? '',
          ),
        )
        .then((v) {
      gettingExchangeRates = false;

      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    var provider = context.watch<CurrencyProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Exchanger'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteConstants.settingsScreen,
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Insert Amount'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CurrencyTextField(
                      isDefault: true,
                      controller: _controller,
                      currency:
                          context.watch<CurrencyProvider>().defaultCurrency!,
                      value: context.read<ConverterProvider>().value.toString(),
                      changed: (v) {
                        if (v) {
                          Future.microtask(
                              () async => await fetchExchangeRates());
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Convert To'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, i) {
                        var data = provider.selectedCurrencies[i];
                        return CurrencyTextField(
                          isDefault: false,
                          controller: null,
                          currency: data,
                          value: getRates(data.code),
                          changed: (v) {
                            // if (v) {
                            //   Future.microtask(
                            //       () async => await fetchExchangeRates());
                            // }
                          },
                        );
                      },
                      separatorBuilder: (context, i) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: provider.selectedCurrencies.length,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteConstants.currencyScreen,
                            arguments: const CurrencyScreen(
                              isDefault: false,
                              currency: null,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(0.25)),
                        child: const Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 2,
                          children: [
                            Icon(
                              CupertinoIcons.plus,
                              color: Colors.greenAccent,
                              size: 12,
                            ),
                            Text(
                              'ADD CONVERTER',
                              style: TextStyle(
                                  color: Colors.greenAccent, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
