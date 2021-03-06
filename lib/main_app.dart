import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_localization/get_localization.dart';

import 'blocs/main_app/main_app_bloc.dart';
import 'blocs/main_app/main_app_contract.dart';
import 'core/base_state.dart';

class MainApp extends StatefulWidget {
  const MainApp({required this.initScreen, Key? key}) : super(key: key);

  final Widget initScreen;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends BaseState<MainAppBloc, MainApp> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAppBloc>(
      create: (BuildContext context) => bloc,
      child: BlocBuilder<MainAppBloc, MainAppData>(
        builder: (BuildContext context, MainAppData data) {
          return MaterialApp(
            theme: data.appThemeData,
            home: widget.initScreen,
            supportedLocales: Localization.localizations.toLocaleList(),
          );
        },
      ),
    );
  }
}
