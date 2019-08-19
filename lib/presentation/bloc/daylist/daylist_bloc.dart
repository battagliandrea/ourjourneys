import 'package:bloc/bloc.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/usecase/fetch_days_usecase.dart';



class DayBloc extends Bloc<DayEvent, DayState> {

  @override
  DayState get initialState => DayUninitialized();

  @override
  Stream<DayState> mapEventToState(DayEvent event) async* {
    if(event is FetchDays){
      try{
        if (currentState is DayUninitialized) {
          var poi = await new FetchDaysUseCase(Injector.providePoiRepository()).fetchDays();
          yield DayLoaded(poi);
        }
      } catch(_){
        yield DayError();
      }
    }
  }
}