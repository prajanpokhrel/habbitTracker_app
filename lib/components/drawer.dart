import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbittacker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Drawer extends StatelessWidget {
  const Drawer(
      {super.key,
      required Color backgroundColor,
      required CupertinoSwitch child});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ));
  }
}
