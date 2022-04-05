import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/entities/event.dart';
import '../../core/base_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/screen_state.dart';
import '../../core/view_actions.dart';
import '../../services/seat_geek/seat_geek_service.dart';
import 'seat_geek_list_contract.dart';

class SeatGeekListBloc extends BaseBloc<SeatGeekListEvent, SeatGeekListData> {
  SeatGeekListBloc(this._seatGeekService) : super(initState) {
    on<InitEvent>((event, emit) => add(GetSeatGeekListEvent(search: '')));
    on<ToggleSearchEvent>(_onToggleSearchEvent);
    on<GetSeatGeekListEvent>(_fetchGetSeatGeekListEvent);
    on<UpdateSeatGeekListEvent>(_onUpdateSeatGeekListEvent);
    on<LikeDislikeEvent>(_onLikeDislikeEvent);
    on<ShowSeatGeekDetailScreenEvent>(
      (event, emit) => dispatchViewEvent(
        NavigateScreen(
          SeatGeekTarget.seatGeekDetailScreen,
          data: event.event,
        ),
      ),
    );
  }

  final SeatGeekService _seatGeekService;

  static SeatGeekListData get initState => (SeatGeekListDataBuilder()
        ..state = ScreenState.loading
        ..isSearching = false
        ..likeToggle = false
        ..eventList = EventList(events: []))
      .build();

  void _onLikeDislikeEvent(
    LikeDislikeEvent event,
    Emitter<SeatGeekListData> emit,
  ) {
    for (final element in state.eventList.events) {
      if (element.id == event.event.id) {
        element.toggleLike();
      }
    }
    emit(state.rebuild((u) => u.likeToggle = u.likeToggle != true));
  }

  void _onToggleSearchEvent(
    ToggleSearchEvent event,
    Emitter<SeatGeekListData> emit,
  ) {
    emit(state.rebuild((u) => u.isSearching = u.isSearching != true));
  }

  void _fetchGetSeatGeekListEvent(
    GetSeatGeekListEvent event,
    Emitter<SeatGeekListData> emit,
  ) {
    _seatGeekService.events(query: event.search).then((response) {
      if (response.errorResult == null) {
        add(UpdateSeatGeekListEvent(state.rebuild((u) {
          u.state = response.data!.events.isEmpty
              ? ScreenState.empty
              : ScreenState.content;
          u.eventList = response.data;
        })));
      } else {
        add(UpdateSeatGeekListEvent(state.rebuild((u) {
          u.state = ScreenState.error;
          u.errorMessage = response.errorResult!.errorMessage;
        })));
      }
    }).catchError((error) {
      add(UpdateSeatGeekListEvent(state.rebuild((u) {
        u.state = ScreenState.error;
        u.errorMessage = error.toString();
      })));
    });
  }

  void _onUpdateSeatGeekListEvent(
    UpdateSeatGeekListEvent event,
    Emitter<SeatGeekListData> emit,
  ) {
    emit(event.state);
  }
}
