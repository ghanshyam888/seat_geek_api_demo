import 'dart:async';
import 'package:flutter_seat_geek/core/error/failures.dart';
import 'package:flutter_seat_geek/core/event_bus.dart';
import 'package:flutter_seat_geek/services/seat_geek/seat_geek_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SeatGeekService])
@GenerateMocks([CustomErrorHandler])
@GenerateMocks([EventBus])
@GenerateMocks([EventBusImpl])
void main() {}
