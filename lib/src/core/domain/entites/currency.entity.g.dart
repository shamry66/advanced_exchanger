// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      code: json['code'] as String,
      country: json['country'] as String,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'code': instance.code,
      'country': instance.country,
      'flag': instance.flag,
    };
