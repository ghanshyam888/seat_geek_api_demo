import '../../api/entities/common.dart';
import '../../api/entities/event.dart';
import '../../api/seat_geek_api/seat_geek_api.dart';

class SeatGeekService {
  SeatGeekService(this._seatGeekApi);
  final SeatGeekApi _seatGeekApi;

  Future<ResponseEntity<EventList?>> events({required String query}) async {
    return _seatGeekApi.events(query);
  }
}
