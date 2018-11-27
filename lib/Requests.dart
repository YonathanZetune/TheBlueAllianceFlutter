import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/EventStats.dart';
import 'package:tba_application/Match.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:intl/date_symbol_data_http_request.dart';
import 'package:date_format/date_format.dart';




class Requests {
    static const String KEY = "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC";

    static Future<List<Team>> getTeamsJsonForRequest(String reqPath) async {
        var path = '/api/v3$reqPath';
        var result = await getResult(path);
        var myTeamsList = TeamList.fromJson(result).teamslist;
        //var dir = await getApplicationDocumentsDirectory();
        //var dirPath = dir.path;
        //var myFile = File('$dirPath/AllTeams.json');
        //print(formatDate(new DateTime(myFile.lastModifiedSync().year,myFile.lastModifiedSync().month, 
        //myFile.lastModifiedSync().day, myFile.lastModifiedSync().minute), [DD, ',',dd, yyyy, '-', MM , '-', dd]));
        //myFile.writeAsStringSync(myTeamsList.toString());
        //print(myFile.readAsStringSync());
   
        return myTeamsList;
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

