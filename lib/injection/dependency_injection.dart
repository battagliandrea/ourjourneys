import 'package:flutter/widgets.dart';
import 'package:our_journeys/data/datasource/datasources.dart';
import 'package:our_journeys/data/repository/repositories.dart';
import 'package:our_journeys/framework/http/client.dart';

enum Flavor { DEVEL }

class Injector {
  static final Injector _singleton = new Injector._internal();

  static BuildContext _context;
  static Flavor _flavor;

  static void configure(BuildContext context, Flavor flavor) {
    _context = context;
    _flavor = flavor;
  }

  static Flavor getFlavor() {
    return _flavor;
  }

  static BuildContext getContext() {
    return _context;
  }

  factory Injector() {
    return _singleton;
  }

  static PostRepository providePostRepository({Client client}) {
    switch (_flavor) {
      case Flavor.DEVEL:
        return new PostRepositoryImpl(new RemoteDataSource(client: client));
      default:
        return new PostRepositoryImpl(new RemoteDataSource(client: client));
    }
  }

  static PoiRepository providePoiRepository({Client client}) {
    switch (_flavor) {
      case Flavor.DEVEL:
        return new PoiRepositoryImpl(new JsonDataSource());
      default:
        return new PoiRepositoryImpl(new JsonDataSource());
    }
  }

  Injector._internal();
}
