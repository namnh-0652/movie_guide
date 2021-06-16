import 'package:json_annotation/json_annotation.dart';
part 'base_error.g.dart';

@JsonSerializable()
class BaseError {
  @JsonKey(name: 'status_code')
  int? code;
  @JsonKey(name: 'status_message')
  String? message;

  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) =>
      _$BaseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$BaseErrorToJson(this);
}
