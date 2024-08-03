import 'package:advanced_exchanger/src/core/providers/currency.provider.dart';
import 'package:advanced_exchanger/src/feature/converter/data/datasources/converter.datasource.dart';
import 'package:advanced_exchanger/src/feature/converter/data/repositories/converter.repository.impl.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/usecase/get_exchange_rate.usecase.dart';
import 'package:advanced_exchanger/src/feature/converter/presentation/provider/converter.provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => CurrencyProvider());

  //! Features - converter
  // Provider
  sl.registerLazySingleton(() => ConverterProvider());

  // Use Case
  sl.registerLazySingleton(() => GetExchangeRateUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ConverterRepositoryImpl>(
      () => ConverterRepositoryImpl(
            dataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<ConverterDataSourceImpl>(
      () => ConverterDataSourceImpl(sl()));
}
