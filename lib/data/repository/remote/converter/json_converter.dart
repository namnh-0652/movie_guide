import 'package:json_annotation/json_annotation.dart';
import 'package:movieguide/data/model/movie_data.dart';

class DataConverter<T> implements JsonConverter<T, Object> {
  const DataConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('title') && json.containsKey('vote_average')) {
        return MovieData.fromJson(json) as T;
      }
      // TODO: Add more cases here
    }
    //? This will only work if `json` is a native JSON type:
    //? num, String, bool, null, etc
    //? *and* is assignable to `T`.
    try {
      return json as T;
    } catch (e) {
      throw e;
    }
  }

  @override
  Object toJson(T object) {
    return object as Object;
  }
}
