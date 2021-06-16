import 'package:movieguide/data/repository/remote/response/base_error.dart';
import 'package:movieguide/domain/error/error_entity.dart';

class HttpError extends ErrorEntity {
  @override
  final Exception? originalException;
  final BaseError? errorResponse;

  HttpError(this.originalException, this.errorResponse)
      : super(
          originalException: originalException,
          errorCode: errorResponse?.code,
          errorMessage: errorResponse?.message,
        );
}

class NetworkError extends ErrorEntity {}

class ServerError extends ErrorEntity {}

class UnexpectedError extends ErrorEntity {}
