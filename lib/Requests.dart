import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/EventStats.dart';
import 'package:tba_application/Match.dart';

class Requests {
    static const String KEY = "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC";

    static Future<List<Team>> getTeamsJsonForRequest(String reqPath) async {
        var path = '/api/v3$reqPath';
        var result = await getResult(path);
        var myTeamsList = TeamList.fromJson(result).teamslist;
        return myTeamsList;
    }
    static Future<List<Team>> getAllTeams() async {
        int page = 0;
        var path = '/api/v3/teams/$page';
        var result =  TeamList.fromJson(await getResult(path)).teamslist;
        List<Team> allTeams = new List<Team>();

         while(result.isNotEmpty){
             for(Team team in result){
                allTeams.add(team);
            }
            page+=1;
            path = '/api/v3/teams/$page';
            result = TeamList.fromJson(await getResult(path)).teamslist;
        }
        return allTeams;
    }

    static Future<List<Event>> getTeamEvents(String teamkey, int year) async {
        var path = '/api/v3/team/$teamkey/events/$year/simple';
        var result = await getResult(path);
        var myTeamsEventsList = EventList.fromJson(result).eventslist;
        return myTeamsEventsList;
    }
    
    static Future<TeamDetail> getTeamDetails(String teamkey) async {
        var path = '/api/v3/team/$teamkey';
        var result = await getResult(path);
        var myTeamDetails = TeamDetail.fromJson(result);
        return myTeamDetails;
    }
    static Future<EventDetail> getEventDetails(String eventkey) async {
        var path = '/api/v3/event/$eventkey';
        var result = await getResult(path);
        var myEventDetails = EventDetail.fromJson(result);
        return myEventDetails;
    }
    static Future<List<Team>> getEventTeams(String eventkey) async {
        var path = '/api/v3/event/$eventkey/teams';
        var result = await getResult(path);
        var myEventTeams = TeamList.fromJson(result).teamslist;
        myEventTeams.sort((a,b) => a.teamInt.compareTo(b.teamInt));
        return myEventTeams;
    }
    static Future<List<Match>> getEventMatches(String eventkey) async {
        var path = '/api/v3/event/$eventkey/matches/simple';
        var result = await getResult(path);
        var myEventMatches= MatchList.fromJson(result).matchlist;
        myEventMatches.sort((b,a) => a.time.compareTo(b.time));
        return myEventMatches;
    }
    static Future<List<String>> getEventOPRs(String eventkey) async {
        var path = '/api/v3/event/$eventkey/oprs';
        var result = await getResult(path);
        var myEventStats = EventStats.fromJson(result).ccwms;
        //myEventMatches.sort((b,a) => a.time.compareTo(b.time));
        return myEventStats;
    }
    static Future<List<Event>> getEventsPerYear(String year) async {
        var path = '/api/v3/events/$year/simple';
        var result = await getResult(path);
        var myEventsPerYear =  EventList.fromJson(result).eventslist;
        myEventsPerYear.sort((a,b) => a.name.compareTo(b.name));
        return myEventsPerYear;
    }
    static Future<Event> getEvent(String key) async {
        var path = '/api/v3/event/$key';
        var result = await getResult(path);
        var myEvent =  Event.fromJson(result);
        return myEvent;
    }

    static Future getResult(String path) async {
        var client = new HttpClient();
        var request = (await client.get('www.thebluealliance.com', 80, path));
        request.headers.set("accept", "application/json");
        request.headers.set("X-TBA-Auth-Key", KEY);  
        var response = await request.close();
        var result =  await response.transform(utf8.decoder).transform(json.decoder).single;
        //print('myres: $result');
        return result;
    }
}

