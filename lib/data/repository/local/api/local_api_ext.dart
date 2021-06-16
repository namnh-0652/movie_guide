import 'package:movieguide/data/repository/local/api/db/app_database.dart';
import 'package:movieguide/data/repository/local/api/error/local_error_mapper.dart';

extension LocalApiExtension on AppDatabase {
  Future<R> execute<R>(Future<R> Function(AppDatabase db) action) async {
    try {
      return await action.call(this);
    } catch (e) {
      throw LocalErrorMapper.instance.map(e);
    }
  }
}
