import 'package:bloc/bloc.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';

class DayBloc extends Bloc<DaysEvent, DaysState> {

  @override
  DaysState get initialState => DayUninitialized();

  @override
  Stream<DaysState> mapEventToState(DaysEvent event) async* {
    if(event is FetchDays){
      try{

        var days = await Injector.providePoiRepository().fetchDays();
        var selectedDay = days.firstWhere((d) => d.index == event.selected);
        yield DaysLoaded(days, selectedDay);

      } catch(_){
        yield DayError();
      }
    }
  }
}