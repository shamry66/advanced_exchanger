import 'package:advanced_exchanger/src/core/domain/entites/currency.entity.dart';

class GetExchangeRateRequest {
  final String baseCurrency;
  final List<Currency> currencies;

  GetExchangeRateRequest({
    required this.baseCurrency,
    required this.currencies,
  });

  Map<String, dynamic> toMap() {
    // var code = [];
    // for (var v in currencies) {
    //   code.add(v.code);
    // }
    var data = {
      "base_currency": baseCurrency,
      // "currencies[]": code
    };


    return data;
  }
}
