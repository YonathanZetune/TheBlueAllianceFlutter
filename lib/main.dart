import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tba_application/teamView.dart';

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
  )
  );
}

class TBAData extends StatefulWidget {
  @override
  
  TBAState createState() => TBAState();
}

class TBAState extends State<TBAData> {
  
  HttpClient myhttp = new HttpClient();
//List<Team> teamData;

    // runs an HTTP get request and returns an HTTPClientResponse
    Future getSWData() async {
        myhttp.get('www.thebluealliance.com', 80, '/api/v3/status')
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
                    builder: (context) =>  TeamViewData(),
                )
            );
        },
                
            )
            
            )
                        
                        ]

                        

                    ), 
                
                
            
            );
                
 
    }

  
    // @override
    void initState() {
        super.initState();
        this.getSWData();
    }
}


