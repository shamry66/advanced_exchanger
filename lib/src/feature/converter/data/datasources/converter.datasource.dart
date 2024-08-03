import 'dart:convert';
import 'dart:io';
import 'package:advanced_exchanger/src/core/constants/constants.dart';
import 'package:advanced_exchanger/src/core/error/exception.dart';
import 'package:advanced_exchanger/src/core/error/socket_exception_handle.dart';
import 'package:advanced_exchanger/src/feature/converter/data/models/get_exchange_rates_request.model.dart';
import 'package:advanced_exchanger/src/feature/converter/domain/entites/exchange_rate.entity.dart';
import 'package:http/http.dart' as http;

abstract class IConverterDataSource {
  Future<List<ExchangeRate>> getExchangeRate(GetExchangeRateRequest request);
}

class ConverterDataSourceImpl implements IConverterDataSource {
  final http.Client httpClient;

  ConverterDataSourceImpl(this.httpClient);

  @override
  Future<List<ExchangeRate>> getExchangeRate(
      GetExchangeRateRequest request) async {
    List<ExchangeRate> rates = [];

    final Map<String, String> headers = {
      "apikey": apikey,
      HttpHeaders.contentTypeHeader: "application/json",
    };

    try {
      Uri uri = Uri(
          scheme: urlScheme,
          host: urlHost,
          port: hostPort,
          path: "/v3/latest",
          queryParameters: request.toMap());
      print(uri.toString());
      final http.Response result = await http.get(
        uri,
        headers: headers,
      );
      print(result.statusCode.toString());

      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        if (response['data'] != null) {
          final Map<String, dynamic> data = response['data'];
          data.forEach((k, v) {
            rates.add(ExchangeRate.fromJson(v));
          });
        }
      } else if (result.statusCode >= 500) {
        throw ServerException("Something went wrong, please try again!");
      } else if (result.statusCode == 401) {
        var response = jsonDecode(result.body);
        if (response != null) throw UnAuthorizedException(response["message"]);
      } else if (result.statusCode >= 400) {
        var response = jsonDecode(result.body);
        if (response != null) throw RequestException(response["message"]);
      } else {
        throw FailureException("Something went wrong, please try again later!");
      }
    } on SocketException catch (e) {
      print(e.message);
      throwWhenSocketException(e);
      return rates;
    } catch (e, t) {
      print(e.toString());
      throw e;
    }
    return rates;
  }
}
