import 'package:advanced_exchanger/src/core/error/failures.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:dartz/dartz.dart';

abstract class IConverterRepository {
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRate(
      GetExchangeRateRequest request);
}
