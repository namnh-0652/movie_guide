import 'package:dio/dio.dart';
import 'package:movieguide/data/repository/remote/response/base_error.dart';
import 'package:movieguide/domain/error/error_entity.dart';

import 'api_error.dart';

extension DioErrorExtension on DioError {
  ErrorEntity toErrorEntity() {
    switch (this.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkError();
      case DioErrorType.response:
        if ((this.response?.statusCode ?? 0) >= 500) {
          return ServerError();
        }
        return HttpError(this, BaseError.fromJson(this.response?.data));
      case DioErrorType.other:
      default:
        return UnexpectedError();
    }
  }
}
