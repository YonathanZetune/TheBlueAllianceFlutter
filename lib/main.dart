import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/teamView.dart';
import 'package:tba_application/Requests.dart';
void main() {
  
  runApp(MaterialApp(
    title: 'TBA',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => TBAData()
      // When we navigate to the "/second" route, build the SecondScreen Widget
      //'/second': (context) => TeamViewData()
    },
  ));
}

class TBAData extends StatefulWidget {
  @override
  
  TBAState createState() => TBAState();
}

class TBAState extends State<TBAData>{
  
  HttpClient myhttp = new HttpClient();
  List<dynamic> data;
  List cellTitle;
  List<Team> teamData;
  Future getSWData() async {

    myhttp.get('www.thebluealliance.com', 80, '/api/v3/status').then((HttpClientRequest request) {
      request.headers.set("accept", "application/json");
      request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((contents) {
       print(contents);
      });
    });
    
  }
  // Future getSWData() async {
  

  //   myhttp.get('www.thebluealliance.com', 80, '/api/v3/status').then((HttpClientRequest request) {
  //     request.headers.set("accept", "application/json");
  //     request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
  //     return request.close();
  //   }).then((HttpClientResponse response) {
  //     response.transform(utf8.decoder).listen((contents) {
  //      //print(contents);
  //     });
  //   });
  //   myhttp.get('www.thebluealliance.com', 80, '/api/v3/teams/0') 
  //   .then((HttpClientRequest request) {
  //     request.headers.set("accept", "application/json");
  //     request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
  //   return request.close();
  //   })
  //     .then((HttpClientResponse response) {
  //      response.transform(utf8.decoder).transform(json.decoder).listen((data) {
  //      // print(data.toString());
  //       setState(() {
  //       TeamList myTeamsL = new TeamList.fromJson(data);
  //       teamData = myTeamsL.teams;
  //               });
       
  //     });
      
  //   });
    
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  TeamViewData(),
                )
            );
          },
        ),
      ),
    );
  }

  
  // @override
  void initState() {
    super.initState();
    this.getSWData();
  
  }
}


