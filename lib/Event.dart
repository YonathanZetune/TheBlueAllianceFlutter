class EventList {
  final List<Event> eventslist;

  EventList({
    this.eventslist,
  });

factory EventList.fromJson(List<dynamic> parsedJson) {

    List<Event> events = new List<Event>();
    events = (parsedJson).map((i)=>Event.fromJson(i)).toList();
    return new EventList(
       eventslist: events,
    );
  }

}
class Event {
    String key;
    String city;
    String date;
    String name;
    String state;
    Event({this.key, this.city, this.date, this.name, this.state});

    factory Event.fromJson(Map<String, dynamic> json) {
        return new Event(
            key: json['key'],
            city: json['city'],
            date: json['start_date'],
            name: json['name'],
            state:json['state_prov']
        );
    }
}
class EventDetail {
    String key;
    String city;
    String date;
    String name;
    String state;
    String address;
    String gmapsurl;
    int week;
    String country;
    EventDetail({this.key, this.city, this.date, this.name, 
    this.state, this.address, this.gmapsurl, this.week, this.country});

    factory EventDetail.fromJson(Map<String, dynamic> json) {
        return new EventDetail(
            key: json['key'],
            city: json['city'],
            date: json['start_date'],
            name: json['short_name'],
            state:json['state_prov'],
            address: json['address'],
            gmapsurl: json['gmaps_url'],
            week: json['week'],
            country: json['country']
        );
    }
}


