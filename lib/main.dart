import 'package:flutter/material.dart';
import 'package:tba_application/Requests.dart';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/teamView.dart';
import 'package:tba_application/EventsList.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(MaterialApp(
    
    title: 'TBA',
    home: new TBAData(),
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/AllTeams': (BuildContext context) => new TBAData()
      //'/AllEvents': (BuildContext context) => new Eventslist()
      // When we navigate to the "/second" route, build the SecondScreen Widget
      //'/second': (context) => TeamViewData()
    },
  )
  );
}

class TBAData extends StatefulWidget {
  @override
  
  TBAState createState() => TBAState();
}

class TBAState extends State<TBAData> {
  
    HttpClient myhttp = new HttpClient();
    final fullTeamsList = Requests.getTeamsJsonForRequest('/teams/0');
    bool downloading = false;
    var progressString = '';

    File jsonFile;
    Directory dir;
    String fileName = 'myTeamsListFile.json';
    bool fileExists = false;
    Map<String, dynamic> fileContent;

    void createFile(Map<String, dynamic> content, Directory dir, String fileName){
        print('creating file');
        File file = new File(dir.path + '/' + fileName);
        file.createSync();
        fileExists = true;
        file.writeAsStringSync(json.encode(content));
        
        
    }

    void writeToFile(String key, dynamic value){
print('writing');
        Map<String, dynamic> content = {key: value};
        if (fileExists){
            print('exists');
            Map<String, dynamic> jsonFileContents = 
            json.decode(jsonFile.readAsStringSync());
            jsonFileContents.addAll(content);
            jsonFile.writeAsStringSync(json.encode(jsonFileContents));

        }else{
            print('not exist');
            createFile(content, dir, fileName);
        }
    }

    // runs an HTTP get request and returns an HTTPClientResponse
    Future getSWData() async {
        for (var team in await Requests.getTeamsJsonForRequest('/teams/0')){
            writeToFile(team.key, team.teamNum);

        }
       
    }
    Future<void> downloadFile() async {
     
     
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
                backgroundColor: Colors.deepPurple[500],
                title: Text('FRC OnDemand'),
            ),
            
            body: 
            Column(
                
                children: <Widget>[
                    SizedBox(
                       width: double.infinity, 
                        child:
                    RaisedButton(
                child: Text('All Teams', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  TeamViewData(),
                )
            );
        },
                
            )
            
            ),
                    SizedBox(
                       width: double.infinity, 
                        child:
                    RaisedButton(
                child: Text('All Events', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  EventsList(),
                )
            );
        },
                
            )
            
            )
                    ,
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

                    ) :Text('No Data'))   
                        ]

                        

                    ), 
                
                
            
            );
                
 
    }

  
    @override
    void initState() {
        super.initState();
        getSWData();
        getApplicationDocumentsDirectory().then((Directory directory){
            dir = directory;
            jsonFile = new File(dir.path + '/' + fileName);
            fileExists = jsonFile.existsSync();
            if (fileExists) {
                this.setState(() => fileContent = 
                json.decode(jsonFile.readAsStringSync()));
            }
        }
        );
        
        downloadFile();
    }
}


