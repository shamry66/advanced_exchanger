import 'package:advanced_exchanger/src/core/domain/usecases/usecase.dart';
import 'package:advanced_exchanger/src/core/error/failures.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/data/repositories/converter.repository.impl.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetExchangeRateUseCase implements UseCase<List<ExchangeRate>, Params> {
  final ConverterRepositoryImpl repository;

  GetExchangeRateUseCase(this.repository);

  @override
  Future<Either<Failure, List<ExchangeRate>>> call(Params params) async =>
      await repository.getExchangeRate(params.request);
}

class Params extends Equatable {
  final GetExchangeRateRequest request;

  const Params({required this.request});

  @override
  List<Object> get props => [request];
}
