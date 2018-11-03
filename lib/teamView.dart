import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tba_application/main.dart';
import 'package:tba_application/Requests.dart';
// class TestClass extends Requests{


// }
class TeamViewData extends StatelessWidget {

//List<Team> myTeams;

ListView makeList(ind, start) {
Requests myRequest = new Requests();
myRequest.setPath('/teams/0');




//TeamList myTeamsL = new TeamList.fromJson(myRequest.teamData);
//         //teamData =  myTeamsL.teams;
//        myData2 = myTeamsL.teams;
myRequest.doResponse();
List<Team> myTeamsList = myRequest.dealWithResponse();
//myTeams = myTeamsList;
// myRequest.teamData;
//TeamList teamLists = myTeamsList.
//var myTeamsList = TeamList.fromJson(myTeamsList2).teams;
print('Teams' + myTeamsList.toString());

  int extra = 0;
  var numPages = 1;
  //print('teamView:'+ myTeamsList[0].nickName);

  return new ListView.builder(
        itemCount: myTeamsList == null ? 0 : 500,
        itemBuilder: (BuildContext context, ind) {
          return new Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text(myTeamsList[ind+start].nickName,    
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black87)), 
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      );
}


TeamViewData({Key key});// : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.youtube_searched_for)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: <ListView>[
        makeList(500 , 0)
            
            ],
          ),
        ),
      ),
    );
  }
}
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("TBA Alliance"),
  //       backgroundColor: Colors.deepPurpleAccent,
  //     ),
  //     body: ListView.builder(
  //       itemCount: myTeamsList == null ? 0 : myTeamsList.length,
        
  //       itemBuilder: (BuildContext context, int index) {
  //         return new Container(
  //           child: Center(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 Card(
  //                   child: Container(
  //                       padding: EdgeInsets.all(15.0),
  //                       child: Row(
  //                         children: <Widget>[
                          
  //                           Text(myTeamsList[index].nickName,    
  //                               style: TextStyle(
  //                                   fontSize: 18.0, color: Colors.black87)), 
  //                         ],
  //                       )),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }



 


