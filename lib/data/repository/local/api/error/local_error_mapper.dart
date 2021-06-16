import 'dart:io';

import 'package:movieguide/data/repository/local/api/error/local_error.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/error/error_mapper.dart';
import 'package:path/path.dart';

class LocalErrorMapper implements ErrorMapper {
  static LocalErrorMapper _instance = LocalErrorMapper._();
  static get instance => _instance;
  LocalErrorMapper._();

  @override
  ErrorEntity map(Exception exception) {
    if (exception is PathException || exception is FileSystemException) {
      return FileError(exception);
    }
    return DatabaseError(exception);
  }
}
