export 'package:our_journeys/data/mapper/post_mapper.dart';

abstract class Convert<T, P> {
  P fromSourceModel(T fromModel);
}