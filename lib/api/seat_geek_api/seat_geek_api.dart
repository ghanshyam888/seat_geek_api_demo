import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/network/rest_api_client.dart';
import '../api_constants.dart';
import '../api_names.dart';
import '../entities/common.dart';
import '../entities/event.dart';

class SeatGeekApi {
  SeatGeekApi(this._apiClient);

  final RestApiClient _apiClient;
  CancelToken? cancelToken;

  Future<ResponseEntity<EventList?>> events(String query) async {
    // if(cancelToken != null){
    //   cancelToken!.cancel('Cancel Request');
    //   cancelToken = null;
    // }
    //cancelToken = CancelToken();
    final response = await _apiClient.request(
      path: Apis.events,
      data: RequestData(
        data: {'client_id': API_KEY, 'q': query},
        type: RequestDataType.query,
      ),
      cancelToken: cancelToken,
      requestMethod: RequestMethod.get,
    );
    if (response.isSuccess) {
      //var _events = response.data!['events'] as List;
      return ResponseEntity(
        EventList(
          //events: _events.map((e) => Event.fromJson(Map.from(e))).toList(),
          events: List.from(response.data!['events'])
              .map((e) => Event.fromJson(e))
              .toList(),
          meta: Meta.fromJson(response.data!['meta']),
        ),
        null,
      );
    }
    return ResponseEntity(null, response.errorResult);
  }
}
