import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class Currency extends Equatable {
  final String code;
  final String country;
  final String? flag;

  const Currency({
    required this.code,
    required this.country,
    required this.flag,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  @override
  List<Object?> get props => [
        code,
        country,
        flag,
      ];
}
