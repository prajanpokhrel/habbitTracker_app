import 'package:isar/isar.dart';
//run cmd to generate the file: dart run build_runner build
part 'habbit.g.dart';

@collection
class Habit {
  //id
  Id id = Isar.autoIncrement;
  // Name of habbit
  late String name;

  //Completed day
  List<DateTime> completeddays = [];
  //DateTime(years, months , day)
  //DateTimr(2024,1,1)
}
