import 'package:flutter/material.dart';
import 'package:habbittacker_app/database/habbit_database.dart';
import 'package:habbittacker_app/pages/homepage.dart';
import 'package:habbittacker_app/themes/dark_mode.dart';
import 'package:habbittacker_app/themes/light_mode%20.dart';

import 'package:habbittacker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize database
  await Habbitdatabase.initialize();
  await Habbitdatabase().saveFirstLaunchDate();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
