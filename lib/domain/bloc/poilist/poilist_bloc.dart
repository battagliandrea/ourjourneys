import 'package:bloc/bloc.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist.dart';

class PoiBloc extends Bloc<PoiEvent, PoiState> {

  @override
  PoiState get initialState => PoiUninitialized();

  @override
  Stream<PoiState> mapEventToState(PoiEvent event) async* {
    if(event is FetchPoi){
      try{
        //if (currentState is PoiUninitialized) {
          var day = await Injector.providePoiRepository().fetchDayByIndex(event.index);
          yield PoiLoaded(day);
        //}
      } catch(_){
        yield PoiError();
      }
    }
  }
}