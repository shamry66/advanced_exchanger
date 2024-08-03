import 'package:advanced_exchanger/src/core/error/failures.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/usecase/get_exchange_rate.usecase.dart';
import 'package:advanced_exchanger/src/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ConverterProvider extends ChangeNotifier {
  final GetExchangeRateUseCase _getExchangeRateUseCase =
      sl<GetExchangeRateUseCase>();

  List<ExchangeRate> _exchangeRate = [];
  List<ExchangeRate> get exchangeRate => _exchangeRate;

  setExchangeRate(List<ExchangeRate> r) {
    _exchangeRate =r;
    notifyListeners();
  }

  double value = 0;

  setValue(double v) {
    value = v;
    notifyListeners();
  }
}
