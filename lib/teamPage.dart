import 'package:flutter/material.dart';
import 'package:tba_application/team.dart';
import 'package:tba_application/EventPage.dart';
import 'package:tba_application/Requests.dart';
import 'package:url_launcher/url_launcher.dart';
class TeamPage extends StatelessWidget{
    final Team myTeam;

    TeamPage(this.myTeam);

    @override
    Widget build(BuildContext context){
        return MaterialApp(
            
            theme: ThemeData(
            primaryColor: Colors.deepPurple[500]
            ),
            home: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    leading: 
                        IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                            Navigator.of(context).popAndPushNamed('/AllTeams');
                            }),
                       
                    bottom: TabBar(
                    tabs: [
                        Tab(icon: Icon(Icons.info_outline), text: 'Info'),
                        Tab(icon: Icon(Icons.event_available), text: 'Events'),
                        Tab(icon: Icon(Icons.perm_media), text: 'Media')
                    ],
                    ),
                    title: Text(myTeam.nickName),

                ),
                body: 
                 Container(
                     child: new
                      TabBarView( 
                            children: [
                       FutureBuilder(
                        future: Requests.getTeamDetails(myTeam.key), 
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
                                                trailing: Text(snapshot.data.teamnum, style: 
                                                TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.deepPurple)),
                                                ),
                                                ListTile(
                                                leading: Icon(Icons.attach_money), 
                                                title: Text(snapshot.data.sponsors),
                                                ),
                                                ListTile(
                                                leading: Icon(Icons.my_location), 
                                                title: Text(snapshot.data.city + ', ' + snapshot.data.state + ', ' + snapshot.data.country),
                                                ),
                                                ListTile(
                                                leading: Icon(Icons.power_settings_new), 
                                                title: Text(snapshot.data.rookieyear),
                                                ),
                                                ListTile(
                                                leading: Icon(Icons.laptop_chromebook), 
                                                title: Text(snapshot.data.website),
                                                onTap: (){
                                                    launch(snapshot.data.website);
                                                }
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
                        future: Requests.getTeamEvents(myTeam.key, 2018), 
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
                                                 leading: Text(snapshot.data[index].state), 
                                                trailing: Text(snapshot.data[index].date),
                                                title: Text(snapshot.data[index].city),
                                                subtitle:  Text(snapshot.data[index].name),
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
                            )
                            ]
                      ),

                            ),
                 ),
            ),
            );
      
    }
}