import 'package:movieguide/data/model/data_model.dart';
import 'package:movieguide/domain/entities/base_entity.dart';

abstract class DataMapper<D extends DataModel, E extends Entity> {
  D mapToData(E entity);
  E mapToDomain(D data);
}
