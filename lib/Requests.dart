import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/teamView.dart';
import 'package:tba_application/main.dart';
class Requests {
  HttpClient myhttp = new HttpClient();
  //List<dynamic> data;
  //List cellTitle;
  List<Team> teamData;
   //List<Team> myData;
  String reqPath;

//Requests({this.reqPath});

//num get req =>Requests.dealWithResponse('fgd').
 void setPath(String path){
  this.reqPath = path;
}

Future doResponse() async{
//HttpClient myhttp =  new HttpClient();
myhttp.get('www.thebluealliance.com', 80, '/api/v3' + reqPath) 
    .then((HttpClientRequest request) {
      request.headers.set("accept", "application/json");
      request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
      return request.close();
    })
      .then((HttpClientResponse response) {
      response.transform(utf8.decoder).transform(json.decoder).listen((conts) {
       // print(data.toString());
       //setState(() {
         //TeamList myTeamsL = new TeamList.fromJson(data).teams;
         print(conts);
         this.teamData =  new TeamList.fromJson(conts).teams;
      //  myData2 = myTeamsL.teams;
         print('dealwith' + this.teamData.toString());
        //dealWithResponse();
         //myRequest = new Requests(teamData: teamData2);
        //return response.;
        //var myTeamV = new TeamViewData(myTeams: teamData,);
      });
    });
}

List<Team> dealWithResponse() {
// List<Team> myData2 = new TeamList().teams;
//var myReque;
//var teamData2;

 print('Datas' + teamData.toString());
 return teamData;

}

    
}


// List<dynamic> getTeamPageNum(int pageNum) {
// String path = '/teams/' + pageNum.toString();
// return dealWithResponse(path);
// }
void initState() {
   // super.initState();
    
  
  }

//Requests(@required this.reqPath);

// class Request{
//   final String path;
//   Request({this.path});
// }