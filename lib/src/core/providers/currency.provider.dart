import 'dart:convert';

import 'package:advanced_exchanger/src/core/domain/entites/currency.entity.dart';
import 'package:advanced_exchanger/src/core/error/failures.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/usecase/get_exchange_rate.usecase.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/provider/converter.provider.dart';
import 'package:advanced_exchanger/src/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyProvider extends ChangeNotifier {
  List<Currency> _currency = [];

  List<Currency> get currency => _currency;

  final SharedPreferences _prefs = sl<SharedPreferences>();

  Currency? _defaultCurrency;

  Currency? get defaultCurrency => _defaultCurrency;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<Currency> _selectedCurrencies = [];

  List<Currency> get selectedCurrencies => _selectedCurrencies;

  final GetExchangeRateUseCase _getExchangeRateUseCase =
      sl<GetExchangeRateUseCase>();

  Future<bool> setSelectedCurrency(Currency c, String? code) async {
    var data = await _prefs.getStringList('selectedCurrencies') ?? [];
    if (data.isEmpty) {
      await _prefs.setStringList('selectedCurrencies', [c.code]);
      _selectedCurrencies.add(_currency.singleWhere((v) => v.code == c.code));
    } else {
      if (code == null) {
        data.add(c.code);
        await _prefs.setStringList('selectedCurrencies', data);
        _selectedCurrencies.clear();
        data.forEach((val) {
          _selectedCurrencies.add(_currency.singleWhere((v) => v.code == val));
        });
      } else {
        var index = data.indexOf(code);
        data.removeAt(index);
        data.insert(index, c.code);
        await _prefs.setStringList('selectedCurrencies', data);
        _selectedCurrencies.clear();
        data.forEach((val) {
          _selectedCurrencies.add(_currency.singleWhere((v) => v.code == val));
        });
      }
    }
    notifyListeners();
    return true;
  }

  Future<bool> removeSelectedCurrency(Currency c) async {
    var data = await _prefs.getStringList('selectedCurrencies') ?? [];
    var index = data.indexOf(c.code);
    data.removeAt(index);
    await _prefs.setStringList('selectedCurrencies', data);
    _selectedCurrencies.clear();
    data.forEach((val) {
      _selectedCurrencies.add(_currency.singleWhere((v) => v.code == val));
    });
    notifyListeners();
    return true;
  }

  Future<bool> setDefaultCurrency(Currency c) async {
    _defaultCurrency = c;
    var success = await _prefs.setString('defaultCurrency', c.code);
    notifyListeners();
    return success;
  }

  setCurrency(BuildContext context) async {
    String jsonString =
        await rootBundle.loadString('assets/currencies-with-flags.json');
    var data = jsonDecode(jsonString);
    _currency = data.map<Currency>((not) => Currency.fromJson(not)).toList();
    var defCurrency = await _prefs.getString('defaultCurrency');

    if (defCurrency == null) {
      _defaultCurrency = _currency.singleWhere((v) => v.code == "LKR");
    } else {
      _defaultCurrency = _currency.singleWhere((v) => v.code == defCurrency);
    }

    List<String> currencies =
        await _prefs.getStringList('selectedCurrencies') ?? [];
    if (currencies.isNotEmpty) {
      currencies.forEach((val) {
        _selectedCurrencies.add(_currency.singleWhere((v) => v.code == val));
      });
    }
    notifyListeners();
    await getExchangeRate(
        context,
        GetExchangeRateRequest(
            baseCurrency: defaultCurrency?.code ?? '',
            currencies: selectedCurrencies));
    notifyListeners();
  }

  Future<List<ExchangeRate>> getExchangeRate(
      context, GetExchangeRateRequest request) async {
    _isLoading = true;
    List<ExchangeRate> rate = [];

    Either<Failure, List<ExchangeRate>> results =
        await _getExchangeRateUseCase(Params(request: request));

    results.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(failure.message),
          backgroundColor: Colors.red,
        ));
      },
      (List<ExchangeRate> res) {
        rate = res;
      },
    );
    notifyListeners();
    Provider.of<ConverterProvider>(context, listen: false)
        .setExchangeRate(rate);
    _isLoading = false;
    return rate;
  }
}
