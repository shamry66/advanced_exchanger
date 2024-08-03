// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRate _$ExchangeRateFromJson(Map<String, dynamic> json) => ExchangeRate(
      code: json['code'] as String?,
      value: (json['value'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ExchangeRateToJson(ExchangeRate instance) =>
    <String, dynamic>{
      'code': instance.code,
      'value': instance.value,
    };
