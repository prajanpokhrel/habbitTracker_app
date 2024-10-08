import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:habbittacker_app/themes/dark_mode.dart';
import 'package:habbittacker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: Drawer());
  }
}
