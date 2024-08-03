import 'dart:convert';

import 'package:advanced_exchanger/src/core/domain/entites/currency.entity.dart';
import 'package:advanced_exchanger/src/core/presentation/screens/currency.screen.dart';
import 'package:advanced_exchanger/src/core/router/route.constants.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/provider/converter.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CurrencyTextField extends StatefulWidget {
  final Currency currency;
  final bool isDefault;
  final String? value;
  final Function(bool) changed;
  final TextEditingController? controller;

  const CurrencyTextField({
    super.key,
    required this.currency,
    required this.isDefault,
    required this.value,
    required this.changed,
    required this.controller,
  });

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: widget.isDefault
          ? TextFormField(
              controller: widget.controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autofocus: false,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),],
              readOnly: !widget.isDefault,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<ConverterProvider>().setValue(double.parse(v));
                } else {
                  context.read<ConverterProvider>().setValue(0);
                }
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                        RouteConstants.currencyScreen,
                        arguments: CurrencyScreen(
                          isDefault: widget.isDefault,
                          currency: widget.currency.code,
                        ),
                      )
                          .then((v) {
                        if (v == true) {
                          widget.changed(true);
                        }
                      });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(
                                  base64Decode(widget.currency.flag!
                                      .replaceFirst(
                                          'data:image/png;base64,', '')),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                        Text(
                          widget.currency.code,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : InputDecorator(
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                        RouteConstants.currencyScreen,
                        arguments: CurrencyScreen(
                          isDefault: widget.isDefault,
                          currency: widget.currency.code,
                        ),
                      )
                          .then((v) {
                        if (v == true) {
                          widget.changed(true);
                        }
                      });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(
                                  base64Decode(widget.currency.flag!
                                      .replaceFirst(
                                          'data:image/png;base64,', '')),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                        Text(
                          widget.currency.code,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              child: Text(
                widget.value ?? '0',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
    );
  }
}
