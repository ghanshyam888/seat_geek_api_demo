// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _registerCache() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => PreferenceStore());
  }

  @override
  void _registerMiscModules() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => CustomErrorHandler())
      ..registerSingleton((c) => NetworkInfoImpl(c<Connectivity>()))
      ..registerSingleton((c) => Connectivity())
      ..registerSingleton((c) => AppTheme(c<PreferenceStore>()));
  }

  @override
  void _registerApis() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => RestApiClient(
          c<Dio>(), c<CustomErrorHandler>(), c<NetworkInfoImpl>()))
      ..registerSingleton((c) => SeatGeekApi(c<RestApiClient>()));
  }

  @override
  void _registerServices() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => SeatGeekService(c<SeatGeekApi>()))
      ..registerSingleton((c) => ThemeService(c<AppTheme>()));
  }

  @override
  void _registerBlocProviders() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => MainAppBloc(c<ThemeService>()))
      ..registerFactory((c) => SeatGeekListBloc(c<SeatGeekService>()));
  }
}
