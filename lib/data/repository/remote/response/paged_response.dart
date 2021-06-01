import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movieguide/data/repository/remote/converter/json_converter.dart';

part 'paged_response.g.dart';

@JsonSerializable()
class PagedResponse<T> extends Equatable {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'total_results')
  final int? totalResults;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'results')
  @DataConverter()
  final List<T>? results;

  PagedResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  int? get nextPage => page == totalPages ? null : page! + 1;

  Map<String, dynamic> toJson() => _$PagedResponseToJson(this);

  factory PagedResponse.fromJson(Map<String, dynamic> json) =>
      _$PagedResponseFromJson(json);

  @override
  List<Object?> get props => [page, totalResults, totalPages, results];
}
