export 'package:our_journeys/data/mapper/poi_mapper.dart';

abstract class Convert<T, P> {
  P fromSourceModel(T fromModel);
}