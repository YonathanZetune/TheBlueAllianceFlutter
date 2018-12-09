import 'package:flutter/material.dart';
import 'package:tba_application/EventPage.dart';
import 'package:tba_application/Requests.dart';
import 'package:tba_application/Event.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
class EventsList extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
                return MaterialApp(
                    theme: ThemeData(
                    primaryColor: Colors.deepPurple[500]
                    ),
                    home: DefaultTabController(
                    
                    length: 3,
                    child: Scaffold(
                        backgroundColor: Colors.grey[300],
                        appBar: AppBar(
                            actions: <Widget>[IconButton(icon: Icon(Icons.search), padding: EdgeInsets.all(18) ,
                    iconSize: 28, onPressed: (){
                            showSearch(context: context, delegate: DataSearch());
                    })],
                            leading: 
                                IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                                    Navigator.of(context).pop('/');
                                    }),
                        
                            title: Text('All Events'),
                        ),
                        body: Container(
                            child: FutureBuilder(
                                future: Requests.getEventsPerYear('2018'),
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
                                                        title: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,    
                                                        children:[
                                                        Expanded(child: Text(snapshot.data[index].name)),
                                                        Expanded(child: Column(children: [Text(snapshot.data[index].date)]))]),
                                                        onTap: (){
                                                        Navigator.push(context,
                                                        new MaterialPageRoute(builder: (context) =>
                                                        EventPage(snapshot.data[index])) 
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
  return File(path + '/' + 'myEventListFile.json');
}
   
    Event getTeamObject(String eventkey) {
        Event myEvent = new Event();
        myEvent.key = eventkey;
        return myEvent;

    }
  
    Future<dynamic> readTeams(String query) async {
        try {
    final file = await _localFile;

    // Read the file
  
    List<Event> contents;
    List<Event> myjson = EventList.fromJson(json.decode(file.readAsStringSync())).eventslist;
    
    contents =  myjson.where((p)=> p.name.toLowerCase().contains(query.toLowerCase())).toList();
    
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

    if(query.isNotEmpty){
    return  FutureBuilder(
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
                                leading: Text(snapshot.data[index].name),
                                trailing: Text(snapshot.data[index].date),
                            
                                onTap: (){
                                    Navigator.push(context,
                                new MaterialPageRoute(builder: (context) =>
                                EventPage(snapshot.data[index])) 
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
            child: Text('Enter an Event Name.'),
        ),
    );
}

}
  

            
  
 
}
          