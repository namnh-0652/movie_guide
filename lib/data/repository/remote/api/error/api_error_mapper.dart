import 'package:dio/dio.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/error/error_mapper.dart';
import 'dio_error_ext.dart';

import 'api_error.dart';

class ApiErrorMapper implements ErrorMapper {
  static ApiErrorMapper _instance = ApiErrorMapper._();
  static get instance => _instance;
  ApiErrorMapper._();
  @override
  ErrorEntity map(Exception exception) {
    if (exception is DioError) {
      return exception.toErrorEntity();
    }
    return UnexpectedError();
  }
}
