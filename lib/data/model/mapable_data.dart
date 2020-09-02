import 'package:movieguide/domain/entities/base_entity.dart';

abstract class MapAbleData<E extends Entity> {
  E map();
}
