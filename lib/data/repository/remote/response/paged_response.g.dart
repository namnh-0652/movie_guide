// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResponse<T> _$PagedResponseFromJson<T>(Map<String, dynamic> json) {
  return PagedResponse<T>(
    page: json['page'] as int,
    totalResults: json['total_results'] as int,
    totalPages: json['total_pages'] as int,
    results:
        (json['results'] as List)?.map(DataConverter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$PagedResponseToJson<T>(PagedResponse<T> instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'results': instance.results?.map(DataConverter<T>().toJson)?.toList(),
    };
