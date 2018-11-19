import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/EventStats.dart';
import 'package:tba_application/Match.dart';


class Requests {

    static Future<List<Team>> getTeamsJsonForRequest(String reqPath) async {
        var client = new HttpClient();
        var path = '/api/v3$reqPath';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myTeamsList = TeamList.fromJson(result).teamslist;
        return myTeamsList;
    }

    static Future<List<Event>> getTeamEvents(String teamkey, int year) async {
        var client = new HttpClient();
        var path = '/api/v3/team/$teamkey/events/$year/simple';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myTeamsEventsList = EventList.fromJson(result).eventslist;
        return myTeamsEventsList;
    }
    static Future<TeamDetail> getTeamDetails(String teamkey) async {
        var client = new HttpClient();
        var path = '/api/v3/team/$teamkey';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myTeamDetails = TeamDetail.fromJson(result);
        return myTeamDetails;
    }
    static Future<EventDetail> getEventDetails(String eventkey) async {
        var client = new HttpClient();
        var path = '/api/v3/event/$eventkey';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myEventDetails = EventDetail.fromJson(result);
        return myEventDetails;
    }
    static Future<List<Team>> getEventTeams(String eventkey) async {
        var client = new HttpClient();
        var path = '/api/v3/event/$eventkey/teams';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myEventTeams = TeamList.fromJson(result).teamslist;
        myEventTeams.sort((a,b) => a.teamInt.compareTo(b.teamInt));
        return myEventTeams;
    }
    static Future<List<Match>> getEventMatches(String eventkey) async {
        var client = new HttpClient();
        var path = '/api/v3/event/$eventkey/matches/simple';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        var myEventMatches= MatchList.fromJson(result).matchlist;
        myEventMatches.sort((b,a) => a.time.compareTo(b.time));
        
        return myEventMatches;
    }
    static Future<List<String>> getEventOPRs(String eventkey) async {
        var client = new HttpClient();
        var path = '/api/v3/event/$eventkey/oprs';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        print('myres: $result');
        var myEventStats = EventStats.fromJson(result).ccwms;
        //myEventMatches.sort((b,a) => a.time.compareTo(b.time));
        
        return myEventStats;
    }
    static Future<List<Event>> getEventsPerYear(String year) async {
        var client = new HttpClient();
        var path = '/api/v3//events/$year/simple';
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        print('myres: $result');
        var myEventsPerYear= EventList.fromJson(result).eventslist;
        //myEventMatches.sort((b,a) => a.time.compareTo(b.time));
        return myEventsPerYear;
    }
}

