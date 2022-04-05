import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_localization/get_localization.dart';

import 'inject/injector.dart';
import 'localizations/en.dart';
import 'main_app.dart';
import 'ui/seat_geek/seat_geek_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Localization.localizations.add(EnglishLocalization());
  await Injector.setup();
  runZoned(() {
    runApp(EntryPoint());
  });
}

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MainApp(
      initScreen: SeatGeekListScreen(),
    );
  }
}
