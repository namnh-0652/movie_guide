// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseError _$BaseErrorFromJson(Map<String, dynamic> json) {
  return BaseError(
    code: json['status_code'] as int,
    message: json['status_name'] as String,
  );
}

Map<String, dynamic> _$BaseErrorToJson(BaseError instance) => <String, dynamic>{
      'status_code': instance.code,
      'status_name': instance.message,
    };
