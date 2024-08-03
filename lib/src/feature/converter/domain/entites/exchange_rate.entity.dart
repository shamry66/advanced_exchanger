import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rate.entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ExchangeRate extends Equatable {
  final String? code;
  @JsonKey(defaultValue: 0)
  final double? value;

  const ExchangeRate({
    required this.code,
    required this.value,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateToJson(this);

  @override
  List<Object?> get props => [
    code,
    value,
  ];
}
