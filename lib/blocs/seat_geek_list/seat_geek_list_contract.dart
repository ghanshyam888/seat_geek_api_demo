import 'package:built_value/built_value.dart';
import '../../api/entities/event.dart';
import '../../core/screen_state.dart';

part 'seat_geek_list_contract.g.dart';

abstract class SeatGeekListData
    implements Built<SeatGeekListData, SeatGeekListDataBuilder> {
  factory SeatGeekListData([void Function(SeatGeekListDataBuilder) updates]) =
      _$SeatGeekListData;

  SeatGeekListData._();

  ScreenState get state;

  String? get errorMessage;

  EventList get eventList;

  bool get isSearching;

  bool get likeToggle;
}

abstract class SeatGeekListEvent {}

class InitEvent extends SeatGeekListEvent {}

class LikeDislikeEvent extends SeatGeekListEvent {
  LikeDislikeEvent({required this.event});
  final Event event;
}

class ShowSeatGeekDetailScreenEvent extends SeatGeekListEvent {
  ShowSeatGeekDetailScreenEvent({required this.event});
  final Event event;
}

class GetSeatGeekListEvent extends SeatGeekListEvent {
  GetSeatGeekListEvent({required this.search});
  final String search;
}

class ToggleSearchEvent extends SeatGeekListEvent {}

class UpdateSeatGeekListEvent extends SeatGeekListEvent {
  final SeatGeekListData state;

  UpdateSeatGeekListEvent(this.state);
}

abstract class SeatGeekTarget {
  static const String seatGeekDetailScreen = 'seat_geek_detail_screen';
}
