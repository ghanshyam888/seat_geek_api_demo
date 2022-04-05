import 'package:intl/intl.dart';

class EventList {
  EventList({
    required this.events,
    this.meta,
  });

  late final List<Event> events;
  late final Meta? meta;
}

class Event {
  Event({
    required this.type,
    required this.id,
    required this.datetimeUtc,
    required this.venue,
    required this.datetimeLocal,
    required this.shortTitle,
    required this.visibleUntilUtc,
    required this.url,
    required this.announceDate,
    required this.title,
  });
  late final String type;
  late final int id;
  late final String datetimeUtc;
  late final Venue venue;
  late final String datetimeLocal;
  late final String shortTitle;
  late final String visibleUntilUtc;
  late final String url;
  late final String announceDate;
  late final String title;
  late final List<Performer> performers;
  bool isLiked = false;

  void toggleLike() {
    isLiked = !isLiked;
  }

  String get localDateTime {
    final date = DateFormat('yyyy-MM-ddThh:mm:ss').parse(datetimeLocal);
    return DateFormat('EEE, dd MMM yyyy h:mma').format(date);
  }

  Event.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    datetimeUtc = json['datetime_utc'];
    venue = Venue.fromJson(json['venue']);
    datetimeLocal = json['datetime_local'];
    shortTitle = json['short_title'];
    visibleUntilUtc = json['visible_until_utc'];
    url = json['url'];
    announceDate = json['announce_date'];
    title = json['title'];
    performers = List.from(json['performers'])
        .map((e) => Performer.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['datetime_utc'] = datetimeUtc;
    _data['venue'] = venue.toJson();
    _data['datetime_local'] = datetimeLocal;
    _data['short_title'] = shortTitle;
    _data['visible_until_utc'] = visibleUntilUtc;
    _data['url'] = url;
    _data['announce_date'] = announceDate;
    _data['title'] = title;
    _data['performers'] = performers.map((e) => e.toJson()).toList();

    return _data;
  }
}

class Venue {
  Venue({
    required this.id,
    required this.displayLocation,
  });
  late final int id;
  late final String displayLocation;

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayLocation = json['display_location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['display_location'] = displayLocation;
    return _data;
  }
}

class Performer {
  Performer({
    required this.name,
    required this.image,
    required this.id,
  });
  late final String name;
  late final String image;
  late final int id;

  Performer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'] ?? '';
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['image'] = image;
    _data['id'] = id;
    return _data;
  }
}

class Meta {
  Meta({
    required this.total,
    required this.took,
    required this.page,
    required this.perPage,
  });
  late final int total;
  late final int took;
  late final int page;
  late final int perPage;

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    took = json['took'];
    page = json['page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['took'] = took;
    _data['page'] = page;
    _data['per_page'] = perPage;
    return _data;
  }
}
