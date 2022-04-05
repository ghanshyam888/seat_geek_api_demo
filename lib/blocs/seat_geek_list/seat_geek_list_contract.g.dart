// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_geek_list_contract.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SeatGeekListData extends SeatGeekListData {
  @override
  final ScreenState state;
  @override
  final String? errorMessage;
  @override
  final EventList eventList;
  @override
  final bool isSearching;
  @override
  final bool likeToggle;

  factory _$SeatGeekListData(
          [void Function(SeatGeekListDataBuilder)? updates]) =>
      (SeatGeekListDataBuilder()..update(updates)).build();

  _$SeatGeekListData._(
      {required this.state,
      this.errorMessage,
      required this.eventList,
      required this.isSearching,
      required this.likeToggle})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(state, 'SeatGeekListData', 'state');
    BuiltValueNullFieldError.checkNotNull(
        eventList, 'SeatGeekListData', 'eventList');
    BuiltValueNullFieldError.checkNotNull(
        isSearching, 'SeatGeekListData', 'isSearching');
    BuiltValueNullFieldError.checkNotNull(
        likeToggle, 'SeatGeekListData', 'likeToggle');
  }

  @override
  SeatGeekListData rebuild(void Function(SeatGeekListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SeatGeekListDataBuilder toBuilder() =>
      SeatGeekListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SeatGeekListData &&
        state == other.state &&
        errorMessage == other.errorMessage &&
        eventList == other.eventList &&
        isSearching == other.isSearching &&
        likeToggle == other.likeToggle;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, state.hashCode), errorMessage.hashCode),
                eventList.hashCode),
            isSearching.hashCode),
        likeToggle.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SeatGeekListData')
          ..add('state', state)
          ..add('errorMessage', errorMessage)
          ..add('eventList', eventList)
          ..add('isSearching', isSearching)
          ..add('likeToggle', likeToggle))
        .toString();
  }
}

class SeatGeekListDataBuilder
    implements Builder<SeatGeekListData, SeatGeekListDataBuilder> {
  _$SeatGeekListData? _$v;

  ScreenState? _state;
  ScreenState? get state => _$this._state;
  set state(ScreenState? state) => _$this._state = state;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  EventList? _eventList;
  EventList? get eventList => _$this._eventList;
  set eventList(EventList? eventList) => _$this._eventList = eventList;

  bool? _isSearching;
  bool? get isSearching => _$this._isSearching;
  set isSearching(bool? isSearching) => _$this._isSearching = isSearching;

  bool? _likeToggle;
  bool? get likeToggle => _$this._likeToggle;
  set likeToggle(bool? likeToggle) => _$this._likeToggle = likeToggle;

  SeatGeekListDataBuilder();

  SeatGeekListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _errorMessage = $v.errorMessage;
      _eventList = $v.eventList;
      _isSearching = $v.isSearching;
      _likeToggle = $v.likeToggle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SeatGeekListData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SeatGeekListData;
  }

  @override
  void update(void Function(SeatGeekListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SeatGeekListData build() {
    final _$result = _$v ??
        _$SeatGeekListData._(
            state: BuiltValueNullFieldError.checkNotNull(
                state, 'SeatGeekListData', 'state'),
            errorMessage: errorMessage,
            eventList: BuiltValueNullFieldError.checkNotNull(
                eventList, 'SeatGeekListData', 'eventList'),
            isSearching: BuiltValueNullFieldError.checkNotNull(
                isSearching, 'SeatGeekListData', 'isSearching'),
            likeToggle: BuiltValueNullFieldError.checkNotNull(
                likeToggle, 'SeatGeekListData', 'likeToggle'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
