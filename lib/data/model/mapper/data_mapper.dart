import 'package:movieguide/data/model/mapable_data.dart';
import 'package:movieguide/domain/entities/base_entity.dart';

class DataMapper {
  R map<R extends Entity>(MapAbleData<R> data) {
    return data.map();
  }

  Iterable<R> collectionMap<R extends Entity>(
      Iterable<MapAbleData<R>> collectionData) {
    return collectionData.map((e) => map(e));
  }
}
