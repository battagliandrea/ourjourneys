import 'package:bloc/bloc.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist.dart';
import 'package:our_journeys/domain/usecase/usecase.dart';


class PoiBloc extends Bloc<PoiEvent, PoiState> {

  @override
  PoiState get initialState => PoiUninitialized();

  @override
  Stream<PoiState> mapEventToState(PoiEvent event) async* {
    if(event is FetchPost){
      try{
        if (currentState is PoiUninitialized) {
          var poi = await new FetchPoiUseCase(Injector.providePoiRepository()).fetchPoi();
          yield PoiLoaded(poi);
        }
      } catch(_){
        yield PoiError();
      }
    }
  }
}