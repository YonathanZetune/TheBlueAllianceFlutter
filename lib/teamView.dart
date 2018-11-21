import 'package:flutter/material.dart';
import 'package:tba_application/teamPage.dart';
import 'package:tba_application/Requests.dart';

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
          