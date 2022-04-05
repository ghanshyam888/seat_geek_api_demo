// ignore_for_file: constant_identifier_names
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';

import '../api/api_names.dart';
import '../api/seat_geek_api/seat_geek_api.dart';
import '../blocs/main_app/main_app_bloc.dart';
import '../blocs/seat_geek_list/seat_geek_list_bloc.dart';
import '../core/cache/preference_store.dart';
import '../core/constants.dart';
import '../core/error/failures.dart';
import '../core/event_bus.dart';
import '../core/network/network_info.dart';
import '../core/network/rest_api_client.dart';
import '../core/utils/app_theme.dart';
import '../services/main_app/theme_service.dart';
import '../services/seat_geek/seat_geek_service.dart';

part 'injector.g.dart';

const String INJECT_KEY_HEADER = 'header';
const String INJECT_KEY_LOGGER = 'logger';

abstract class Injector {
  static late KiwiContainer container;

  static Future<bool> setup() async {
    container = KiwiContainer();

    _$Injector()._configure();

    // initialize preference store
    final preferenceStore = container.resolve<PreferenceStore>();
    return preferenceStore.init();
  }

  // For use from classes trying to get top-level
  // dependencies such as ChangeNotifiers or BLoCs
  static final T Function<T>([String]) resolve = container.resolve;

  void _configure() {
    // Configure modules here
    _registerConstants();
    _configureBus();
    _configureNetworkModule();
    _registerApis();
    _registerServices();
    _registerCache();
    _registerMiscModules();
    _registerBlocProviders();
  }

  void _configureBus() {
    container.registerSingleton<EventBus>((c) => EventBusImpl());
  }

  void _registerConstants() {
    container.registerSingleton((c) => API_URL, name: API_KEY);
  }

  /// Register Network modules
  void _configureNetworkModule() {
    _configureLogInterceptor();
    _configureHeaderInterceptor();
    _configureDio();
  }

  void _configureLogInterceptor() {
    container.registerSingleton<Interceptor>(
        (c) => LogInterceptor(
            request: true,
            requestBody: true,
            responseHeader: true,
            requestHeader: true,
            responseBody: true,
            error: true),
        name: INJECT_KEY_LOGGER);
  }

  void _configureHeaderInterceptor() {
    container.registerSingleton<Interceptor>(
        (c) => InterceptorsWrapper(onRequest:
                (RequestOptions options, RequestInterceptorHandler handler) {
              return handler.next(options);
            }),
        name: INJECT_KEY_HEADER);
  }

  void _configureDio() {
    final baseOptions = BaseOptions(
      baseUrl: container.resolve(API_KEY),
      connectTimeout: CONNECTION_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
    );
    final dio = Dio(baseOptions);
    dio.interceptors.add(container.resolve(INJECT_KEY_HEADER));
    if (!kReleaseMode) {
      dio.interceptors.add(container.resolve(INJECT_KEY_LOGGER));
    }
    container.registerSingleton((c) => dio);
  }

  /// Register Data Stores
  @Register.singleton(PreferenceStore)
  void _registerCache();

  /// Register Misc
  @Register.singleton(CustomErrorHandler)
  @Register.singleton(NetworkInfoImpl)
  @Register.singleton(Connectivity)
  @Register.singleton(AppTheme)
  void _registerMiscModules();

  /// Register Apis
  @Register.singleton(RestApiClient)
  @Register.singleton(SeatGeekApi)
  void _registerApis();

  /// Register Services
  /// @Register.singleton(AnalyticsService, from: AnalyticsServiceImpl)
  @Register.singleton(SeatGeekService)
  @Register.singleton(ThemeService)
  void _registerServices();

  /// Register Bloc dependencies
  @Register.factory(MainAppBloc)
  @Register.factory(SeatGeekListBloc)
  void _registerBlocProviders();
}
