import 'package:flutter/material.dart';

import '../../core/base_bloc.dart';
import '../../core/screen_state.dart';
import '../../core/view_actions.dart';
import '../../services/main_app/theme_service.dart';
import 'main_app_contract.dart';

class MainAppBloc extends BaseBloc<MainAppEvent, MainAppData> {
  MainAppBloc(this._themeService) : super(initState) {
    on<InitEvent>(_initEvent);
    on<ChangeThemeEvent>(_changeTheme);
  }

  final ThemeService _themeService;

  static MainAppData get initState => (MainAppDataBuilder()
        ..state = ScreenState.content
        ..appThemeData = ThemeData.light())
      .build();

  void _initEvent(_, emit) => emit(
      state.rebuild((u) => u..appThemeData = _themeService.getThemeData()));

  void _changeTheme(_, emit) {
    emit(state.rebuild((u) {
      _themeService.changeTheme();
      u.appThemeData = _themeService.getThemeData();
    }));
    dispatchViewEvent(ChangeTheme());
  }
}
