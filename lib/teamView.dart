import 'package:flutter/material.dart';
import 'package:tba_application/teamPage.dart';
import 'package:tba_application/Requests.dart';
import 'package:tba_application/team.dart';
import 'package:tba_application/main.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

import 'dart:io';

class TeamViewData extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(
            primaryColor: Colors.deepPurple[500]
            ),
            home: DefaultTabController(
            
            length: 3,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    actions: <Widget>[IconButton(icon: Icon(Icons.search), padding: EdgeInsets.all(18) ,
                    iconSize: 28, onPressed: (){
                            showSearch(context: context, delegate: DataSearch());
                    })],
                    leading: 
                        IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                            Navigator.of(context).pop('/');
                            }),
                
                    title: Text('All Teams'),
                ),
                body: Container(
                    child: FutureBuilder(
                        future: Requests.getTeamsJsonForRequest('/teams/0'),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                            if (snapshot.data == null){
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()
                                    ),

                                );
                            } else {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                    return Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                                ListTile(
                                                leading: Text(snapshot.data[index].teamNum),
                                                title: Text(snapshot.data[index].nickName),
                                                subtitle:  Text(snapshot.data[index].motto),
                                                onTap: (){
                                                    Navigator.push(context,
                                                new MaterialPageRoute(builder: (context) =>
                                                TeamPage(snapshot.data[index])) 
                                                );
                                              } 

                                            )
                                           
                                          ]
                                          
                                        )
                                        
                                    );
                                     
                                }
                                
                            );
                        }
                            }
                    ),

                ),
            ),
        ),
        );
    }
}

class DataSearch extends SearchDelegate<String>{
    Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

    Future<File> get _localFile async {
  final path = await _localPath;
  return File(path + '/' + 'myTeamsListFile.json');
}
   
    Team getTeamObject(String teamkey) {
        Team myTeam = new Team();
        myTeam.key = teamkey;
        return myTeam;

    }
  
    Future<dynamic> readTeams(String query) async {
        try {
    final file = await _localFile;

    // Read the file
  
    List<Team> contents;
    List<Team> myjson = TeamList.fromJson(json.decode(file.readAsStringSync())).teamslist;
    if(int.tryParse(query)!=null){
        contents= myjson.where((p)=> p.teamInt.toString().contains(int.tryParse(query).toString())).toList();

    }else{
    contents =  myjson.where((p)=> p.nickName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    //print('CONTS:' + contents.toString());
    return contents;
  } catch (e) {
      //print('HERE');
      print(e);
    // If we encounter an error, return 0
   
  }
 // return List<Team>();


}

static bool calledAlready = false;
static List myListTeams;

  @override
  List<Widget> buildActions(BuildContext context) {
    // When I have the search bar, what actions do i want to perform (actions for search bar)
    return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){
            query = '';

        })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on app bar
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,),
    onPressed: (){
        close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show based on selection
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show something when entering search bar
    
//    // print('LENGTH' + myListTeams.length.toString());
    List<Team> suggestionList;
    if(query.isNotEmpty){
     //suggestionList = myListTeams.where((p)=> p.nickName.toLowerCase().contains(query.toLowerCase())).toList();
    return 
            FutureBuilder(
                        future: readTeams(query),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                            if (snapshot.data == null){
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()
                                    ),

                                );
                            } else {
                        return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                            return  ListTile(
                                leading: Text(snapshot.data[index].nickName),
                                trailing: Text(snapshot.data[index].teamNum),
                            
                                onTap: (){
                                    Navigator.push(context,
                                new MaterialPageRoute(builder: (context) =>
                                TeamPage(snapshot.data[index])) 
                                );
                                } 

                            );
                        }
                    );
                 }
                        }     
    );
}else{
    return Container(
        child: Center(
            child: Text('Enter a team or number.'),
        ),
    );
}

}
  

            
  
 
}
