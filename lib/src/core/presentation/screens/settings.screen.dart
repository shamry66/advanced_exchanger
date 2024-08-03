import 'dart:convert';

import 'package:advanced_exchanger/src/core/providers/currency.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Currencies'),
      ),
      body: Consumer<CurrencyProvider>(
        builder: (context, provider, child) {
          var currencies = provider.selectedCurrencies;

          if (currencies.isEmpty) {
            return const Center(
              child: Text('Selected Currencies Not Found!'),
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
                    trailing: IconButton(
                      onPressed: () {
                        provider.removeSelectedCurrency(data).then((v) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${data.code} Removed Successfully'))
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )),
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
