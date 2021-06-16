import 'package:movieguide/data/repository/remote/api/error/api_error_mapper.dart';

import 'movie_api.dart';

extension RemoteApiExtension on MovieApi {
  Future<R> execute<R>(Future<R> Function(MovieApi api) action) async {
    try {
      return await action.call(this);
    } catch (e) {
      throw ApiErrorMapper.instance.map(e);
    }
  }
}
