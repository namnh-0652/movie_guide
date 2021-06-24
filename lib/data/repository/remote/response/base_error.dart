import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_error.g.dart';

@JsonSerializable()
class BaseError extends Equatable {
  @JsonKey(name: 'status_code')
  final int? code;
  @JsonKey(name: 'status_message')
  final String? message;

  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) =>
      _$BaseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$BaseErrorToJson(this);

  @override
  List<Object?> get props => [code, message];
}
