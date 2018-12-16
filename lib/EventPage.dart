import 'package:flutter/material.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/Requests.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
class EventPage extends StatelessWidget{
    final Event myEvent;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    _showSnackBar(String text){
        print('Snacking');
        final snackbar = new SnackBar(
            duration: Duration(seconds: 1),
            content: new Text(text),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
    }
    EventPage(this.myEvent);
     _addFavorite() async {
         
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //List<String> keys = (prefs.getStringList('key') ?? ['']);
  //print('Pressed $keys times.');
  if(prefs.getStringList('key') != null && prefs.getStringList('key').contains(myEvent.key)){
      List<String> myKeys = prefs.getStringList('key');
      myKeys.remove(myEvent.key);
      _showSnackBar('Removed from favorites');
      await prefs.setStringList('key', (myKeys));
  }else{ 
      if(prefs.getStringList('key') != null){
  List<String> myKeys = prefs.getStringList('key') + [myEvent.key];
  await prefs.setStringList('key', (myKeys));
      }else{
          List<String> myKeys = [myEvent.key];
  await prefs.setStringList('key', (myKeys));
      }
      _showSnackBar('Added to favorites');
     }
  print(prefs.getStringList('key'));
}
    List<Widget> getTeamNameList(List<dynamic> myList){
        List<Widget> returnList = new List<Widget>();
        for (var team in myList){
            var myTeamVal = team.toString();
            if (myTeamVal.contains('frc')){
                myTeamVal = myTeamVal.substring(3);
            }
            returnList.add(Text(myTeamVal));
        }
        return returnList;
    }
    

    @override
    Widget build(BuildContext context){
        return MaterialApp(
            theme: ThemeData(
            primaryColor: Colors.deepPurple[500]
            ),
            home: DefaultTabController(
            length: 4,
            child: Scaffold(
                key: _scaffoldKey,
                 floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.favorite),
                    tooltip: 'Add to Favorites',
                    onPressed: (){
                    _addFavorite();
                    }
                ),
                
                backgroundColor: Colors.white.withAlpha(225),
                appBar: AppBar(
                        leading: 
                        IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                            Navigator.of(context).pop();
                            }),
                    bottom: TabBar(
                    tabs: [
                        Tab(text: 'Info'),
                        Tab(text: 'Teams',),
                        Tab(text: 'Matches'),
                        Tab(text: 'Ranks')
                    ],
                    ),
                    title: Text(myEvent.name),

                ),
                body: 
                 Container(
                     child: 
                      TabBarView( 
                            children: [
                                FutureBuilder(
                                future: Requests.getEventDetails(myEvent.key), 
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                    if (snapshot.data == null){
                                        return Container(
                                            child: Center(
                                                child: CircularProgressIndicator()
                                            ),
                                        );
                                    } else {
                                    return ListView.builder(
                                        itemCount: 1,
                                        itemBuilder: (BuildContext context, int index){
                                        return  Card(
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                        ListTile(
                                                        leading: Icon(Icons.info_outline), 
                                                        title: Text(snapshot.data.name),
                                                        subtitle: Text(snapshot.data.address),
                                                        ),
                                                        ListTile(
                                                        leading: Icon(Icons.view_week), 
                                                        title: Text('Week: ' + (snapshot.data.week).toString()),
                                                        ),
                                                        ListTile(
                                                        leading: Icon(Icons.location_city), 
                                                        title: Text(snapshot.data.city + ', ' + snapshot.data.state + ', ' + snapshot.data.country),
                                                        ),
                                                        ListTile(
                                                        leading: Icon(Icons.my_location), 
                                                        title: Text(snapshot.data.gmapsurl),
                                                        onTap: (){
                                                            launch(snapshot.data.gmapsurl);
                                                        },
                                                        ),
                                                        
                                                
                                                ]

                                                )

                                            ); 
                                        }
                                        
                                    );
                                    }
                                }
                            ),
                                FutureBuilder(
                                future: Requests.getEventTeams(myEvent.key), 
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
                                                    )
                                                
                                                ]

                                                )

                                            ); 
                                        }
                                        
                                    );
                                    }
                                }
                            ),
                                
                                FutureBuilder(
                            future: Requests.getEventMatches(myEvent.key), 
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
                                                 title:
                                                
                                                    Row(
                                                
                                                crossAxisAlignment: CrossAxisAlignment.center,    
                                                children:[
                                                
                                                Expanded(
                                                    
                                                    child:
                                                Text(snapshot.data[index].alliances[0].score.toString(),
                                                 style: 

                                                TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.red)),
                                                ),
                                                Expanded(
                                                    child:
                                                    Column(
                                                    
                                                   children: getTeamNameList(snapshot.data[index].alliances[0].teamkeys)
                                                        )
                                                ),

                                                    Expanded(
                                                        child:
                                                    Column(
                                                            
                                                    children:[Text(snapshot.data[index].complevel, style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)]
                                                    )),
                                                    Expanded(
                                                        child:
                                                    Column(
                                                   children: getTeamNameList(snapshot.data[index].alliances[1].teamkeys)
                                                        )),
                                                    Expanded(
                                                        child:  
                                                    Text(snapshot.data[index].alliances[1].score.toString(),
                                                    style: 
                                                    TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.blue)),
                                                    )
                                                        ]
                                                    ),
                                                    
                                      
                                            )
                                                
                                          ]

                                        )

                                    ); 
                                }
                                
                            );
                            }
                        }
                            ),
                                FutureBuilder(
                            future: Requests.getEventOPRs(myEvent.key), 
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                                if (snapshot.data == null){
                                    return Container(
                                        child: Center(
                                            child: CircularProgressIndicator()
                                        ),
                                    );
                                } else {
                                    return  
                                    ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context, int index){
                                     return Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[  
                                                
                                                ListTile(
                                                 leading: Text('Rank '+(index+1).toString()+':'),   
                                                 title: getTeamNameList(snapshot.data)[index],
                                                
                                                            )
                                                        ]
                                                    ),
                                    
                                            );
                                        }
                                    ); 
                                    }
                                    }
                                    ),
                                    ]
                                        )

                                    ), 

            
                      ),

            )
        );
                 
                       
                                
      
    }
}


