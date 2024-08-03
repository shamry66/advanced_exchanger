import 'package:advanced_exchanger/src/core/error/exception.dart';
import 'package:advanced_exchanger/src/core/error/failures.dart';
import 'package:advanced_exchanger/src/feature/converter/data/datasources/converter.datasource.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/repositories/iconverter.repository.dart';
import 'package:dartz/dartz.dart';

class ConverterRepositoryImpl extends IConverterRepository {
  final ConverterDataSourceImpl dataSource;

  ConverterRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRate(
      GetExchangeRateRequest request) async {
    try {
      return Right(await dataSource.getExchangeRate(request));
    } on UnAuthorizedException catch (e) {
      return Left(UnAuthorizedFailure(e.message));
    } on ServerException {
      return const Left(
          ServerFailure("Processing failed, try again in few minutes!"));
    } on RequestException catch (e) {
      return Left(AppFailure(e.message));
    } on InternetConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on TimeoutConnectionException catch (e) {
      return Left(TimeoutFailure(e.message));
    } catch (e) {
      print(e.toString());
      return const Left(AppFailure("Something went wrong, please try again!"));
    }
  }
}
