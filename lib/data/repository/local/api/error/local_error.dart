import 'package:movieguide/domain/error/error_entity.dart';

class DatabaseError extends ErrorEntity {
  @override
  final Exception? originalException;

  DatabaseError(this.originalException)
      : super(originalException: originalException);
}

class FileError extends ErrorEntity {
  @override
  final Exception? originalException;

  FileError(this.originalException)
      : super(originalException: originalException);
}
