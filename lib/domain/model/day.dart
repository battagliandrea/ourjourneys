
import 'package:intl/intl.dart';
import 'package:our_journeys/domain/model/models.dart';

class Day {

  int index;
  DateTime date;
  List<Poi> poi;

  Day(this.index, this.date, this.poi);

  String getFormattedDate(){
    return "${new DateFormat("dd MMMM").format(this.date)}";
  }
}