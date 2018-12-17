import 'package:flutter/material.dart';
import 'package:tba_application/Requests.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/EventsList.dart';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/teamView.dart';
import 'package:tba_application/team.dart';
import 'package:tba_application/teamPage.dart';
import 'package:tba_application/FavoriteList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';


void main() {
    
  runApp( MaterialApp(
      
    
    //key: Key('one'),
    title: 'TBA',
    home: TBAData(),
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      
      '/AllTeams': (context) => TeamViewData(),
      '/AllTeams/Team': (context) => new TeamPage(new Team()),
      '/AllEvents': (context) => EventsList(),
      
      '/Favs': (context) => FavoriteList()
      //'/AllEvents': (BuildContext context) => new Eventslist()
      // When we navigate to the "/second" route, build the SecondScreen Widget
      //'/second': (context) => TeamViewData()
    },
    debugShowCheckedModeBanner: false,
  )
  
  );
}

class TBAData extends StatefulWidget {
  @override
  
  TBAState createState() => TBAState();
}

class TBAState extends State<TBAData> {
    
    HttpClient myhttp = new HttpClient();
    bool downloading = false;
    var progressString = '';
    File jsonFile;
    File jsonEventFile;
    Directory dir;
    Directory eventdir;
    String fileName = 'myTeamsListFile.json';
    String eventfileName = 'myEventListFile.json';
    bool fileExists = false;
    bool eventfileExists = false;
    Map<String, dynamic> fileContent;
    Map<String, dynamic> fileEventContent;
    List<Map<String, dynamic>> jsonFileContents;
    List<Map<String, dynamic>> jsonEventFileContents;
    List<Map<String, dynamic>> eventcontent = new List<Map<String, dynamic>> ();
    List<Map<String, dynamic>> content = new List<Map<String, dynamic>> ();

    void createFile(List<Map<String, dynamic>> content, Directory dir, String thisfileName){
        print('creating file');
        
        File file = new File(dir.path + '/' + thisfileName);
        file.createSync();
        //fileExists = true;
        file.writeAsStringSync(json.encode(content));
        
        
    }
    void writeTeamsToFile(List<Team> team){
    print('writing');
        content.clear();
        //content.clear();
        for(Team i in team) {
            //print('HERE');
    Map<String, dynamic> myTeam =    {
    "key": i.key,
    "team_number": i.teamInt,
    "nickname": i.nickName,
   
  };
  content.add(myTeam);
        }
        try{
            jsonFile.delete();
        } catch(e){
            print(e.toString());
        }
        
        if (fileExists){
            print('exists');
            if(jsonFileContents == null){
               jsonFileContents = new List<Map<String, dynamic>>();
               jsonFileContents.clear();
            }
            jsonFileContents = content;
            jsonFile.writeAsStringSync(json.encode(jsonFileContents), mode: FileMode.writeOnlyAppend);

        }else{
            print('not exist');
            createFile(content, dir, fileName);
        }
    }
    void writeEventsToFile(List<Event> events){
    print('writingE');
        eventcontent.clear();
        //content.clear();
        for(Event i in events) {

            //print('HERE');
    Map<String, dynamic> myEvent =    {
    "key": i.key,
    "city": i.city,
    "start_date": i.date,
    "name": i.name,
    "state_prov": i.state
   
  };

  eventcontent.add(myEvent);
        }
        try{
            jsonEventFile.delete();
        } catch(e){
            print(e.toString());
        }
        
        if(eventfileExists){
            
            print('exists');
            if(jsonEventFileContents == null){
               jsonEventFileContents = new List<Map<String, dynamic>>();
               jsonEventFileContents.clear();
            }
            jsonEventFileContents = eventcontent;
            jsonEventFile.writeAsStringSync(json.encode(jsonEventFileContents), mode: FileMode.writeOnlyAppend);

        }else{
            print('not exist');
            createFile(eventcontent, eventdir, eventfileName);
        }
    }

    // runs an HTTP get request and returns an HTTPClientResponse
    Future getSWData() async {
       writeEventsToFile(await Requests.getEventsPerYear('2018'));
        writeTeamsToFile(await Requests.getAllTeams());
    }

    Future<void> downloadFile() async {
        // Stream<DocumentSnapshot> data = Firestore.instance.collection('Data').document('CurrentYear').snapshots();
        // var year = 
        //print('DATA:' +  data.toString());
        await myhttp.get('www.thebluealliance.com', 80, '/api/v3/status')
        .then((HttpClientRequest request) {
            request.headers.set("accept", "application/json");
            request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
            return request.close();
        }).then((HttpClientResponse response) {
            response.transform(utf8.decoder).listen((contents) {
             print(contents);
            });
        });
        myhttp.close();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white.withAlpha(225),
            appBar: AppBar(
                actions: <Widget>[IconButton(icon: Icon(Icons.refresh), padding: EdgeInsets.all(18) ,
                    iconSize: 28, onPressed: (){
                            
                    })],
                backgroundColor: Colors.deepPurple[500],
                title: Text('FRC Now'),
            ),
            body: 
            Column(
                
                children: <Widget>[
                    SizedBox(
                       width: double.infinity, 
                        child:
                    RaisedButton(
                        
                color: Colors.grey[400],
                child: Text('All Teams', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                onPressed: () {
            // Navigate to the second screen using a named route
           Navigator.pushNamed(context, '/AllTeams');
                
            
        },
                
            )
            
            ),
                    SizedBox(
                       width: double.infinity, 
    
                        child:
                    RaisedButton(
                color: Colors.grey[400],
                child: Text('All Events', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/AllEvents');
        },
                
            )
            
            ),
                    SizedBox(
                       width: double.infinity,
      
                        child:
                    RaisedButton(
                color: Colors.grey[400],
                child: Text('Favorites', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context,'/Favs');
        },
                
            )
            
            ),
                    
                    SizedBox(
                        width: double.infinity, 
                        child:
                         downloading ?
                    Container(
                        height: 120,
                        width: 200,
                        child: Card(
                            color: Colors.black,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    CircularProgressIndicator(),
                                    SizedBox(height: 20),
                                    Text('Downloading file : $progressString',style: TextStyle(color: Colors.white),)
                                ],
                            ),
                        ),

                    ) :Text(''))   
                        ]

                        

                    ), 
                
                
            
            );
                
 
    }

  
    @override
    void initState() {
        super.initState();
        downloadFile();
        getSWData();
        getApplicationDocumentsDirectory().then((Directory directory){
            dir = directory;
            eventdir = directory;
            jsonFile = new File(dir.path + '/' + fileName);
            jsonEventFile = new File(dir.path + '/' + eventfileName);
            eventfileExists = jsonEventFile.existsSync();
            fileExists = jsonFile.existsSync();
            if (fileExists) {
               fileContent = 
                json.decode(jsonFile.readAsStringSync());
            }
            if (eventfileExists) {
                eventcontent = 
                json.decode(jsonEventFile.readAsStringSync());
            }
        }
        );
        
        
    }
}


