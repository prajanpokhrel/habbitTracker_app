import 'package:isar/isar.dart';

//run cmd to generate the file: dart run build_runner build
part 'app_setting.g.dart';

@collection
class Appsetting {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}
