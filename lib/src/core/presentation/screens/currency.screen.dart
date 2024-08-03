import 'dart:convert';

import 'package:advanced_exchanger/src/core/providers/currency.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyScreen extends StatefulWidget {
  final bool isDefault;
  final String? currency;

  const CurrencyScreen(
      {super.key, required this.isDefault, required this.currency});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Currency'),
      ),
      body: Consumer<CurrencyProvider>(
        builder: (context, provider, child) {
          var currencies = provider.currency;

          if (currencies.isEmpty) {
            return const Center(
              child: Text('Currencies Not Found!'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: currencies.length,
            itemBuilder: (context, i) {
              var data = currencies[i];
              var image = base64Decode(currencies[i]
                  .flag!
                  .replaceFirst('data:image/png;base64,', ''));
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () {
                    if (widget.isDefault) {
                      context
                          .read<CurrencyProvider>()
                          .setDefaultCurrency(data)
                          .then((v) {
                        Navigator.of(context).pop(true);
                      });
                    } else {
                      if (data == provider.defaultCurrency) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You Cant Select Default Currency'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        if (provider.selectedCurrencies.contains(data)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('You Already Selected ${data.code}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          provider
                              .setSelectedCurrency(data, widget.currency)
                              .then((v) {
                            Navigator.of(context).pop(true);
                          });
                        }
                      }
                    }
                  },
                  title: Text(
                    data.country,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    data.code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  leading: SizedBox(
                    width: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(
                            image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                    ),
                  ),
                  trailing: widget.currency == data.code
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Visibility(
                          visible: provider.defaultCurrency == data,
                          replacement: Visibility(
                            visible: provider.selectedCurrencies.contains(data),
                            child: const Text(
                              'Selected',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              );
            },
            separatorBuilder: (context, i) {
              return const SizedBox(
                height: 8,
              );
            },
          );
        },
      ),
    );
  }
}
