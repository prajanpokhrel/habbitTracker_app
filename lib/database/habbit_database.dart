import 'package:flutter/cupertino.dart';
import 'package:habbittacker_app/models/app_setting.dart';
import 'package:habbittacker_app/models/habbit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Habbitdatabase extends ChangeNotifier {
  static late Isar isar;

  /*
  setup
  */

  //Initialize the Database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppsettingSchema], directory: dir.path);
  }

  // save the first date of app startup(heat map)
  Future<void> saveFirstLaunchDate() async {
    final existingSetting = await isar.appsettings.where().findFirst();
    if (existingSetting == null) {
      final settings = Appsetting()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appsettings.put(settings));
    }
  }

  // Get the first date of app startup (heat map)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appsettings.where().findFirst();
    return settings?.firstLaunchDate;
  }
  /*
  CRUD OPERATIONS

*/
// List of the habbit
//CREATE - Add new habbit
// READ - read and saved habbit from db
// UPADTE - Modify data from database
// Delete - Delete the habbit from database
}
