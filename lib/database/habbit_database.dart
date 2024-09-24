import 'dart:js_interop_unsafe';

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
  final List<Habit> currnetHabits = [];

//CREATE - Add new habbit
  Future<void> addHabits(String habitName) async {
    final newhabit = Habit()..name = habitName;
    //save to database
    await isar.writeTxn(() => isar.habits.put(newhabit));
    // re reads from db
    readHabit();
  }

// READ - read and saved habbit from db
  Future<void> readHabit() async {
    // fetch all the habits from database
    List<Habit> fecthHabits = await isar.habits.where().findAll();
    //give to the currnet habits
    currnetHabits.clear();
    currnetHabits.addAll(fecthHabits);
    // update the ui
  }

// UPADTE - check habit on and off
  Future<void> updateHabitCompletion(int id, bool iscompleted) async {
    //find the specific habit
    final habit = await isar.habits.get(id);
    //update vaye pchi ko
    if (habit != null) {
      await isar.writeTxn(() async {
        //if habit is completed -< add the current date to the completedDays list
        if (iscompleted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();
          // add the current date if its not already in the list
          habit.completedDays.add(DateTime(today.year, today.day, today.month));
// if habit is not completed -> remove the currnt date fromthe list
        } else {
          // remove the current date is habbit is not marked as completed
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
        //save the updated habits back to the db
        await isar.habits.put(habit);
      });
    }
    readHabit();
  }

  // update _edit habit name
  Future<void> UpdateHabitName(int id, String newName) async {
    //find the specific habbit name
    final habit = await isar.habits.get(id);
    //update habbit name
    if (habit != null) {
      //update name
      await isar.writeTxn(() async {
        habit.name = newName;
        //save updated habit back to db
        await isar.habits.put(habit);
      });
    }
    // re read  from db
    readHabit();
  }

// Delete - Delete the habbit from database
  Future<void> deleteHabit(int id) async {
    //perform the delete
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    //re read from db
    readHabit();
  }
}
