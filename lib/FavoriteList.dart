import 'package:flutter/material.dart';
import 'package:tba_application/EventPage.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/Requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList extends StatelessWidget {
    Future<List<Event>> getFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Event> myEvents = new List<Event>();

  for (var key in prefs.getStringList('key') ?? ['']){
      myEvents.add(await Requests.getEvent(key));
  }
    return myEvents;
}
        @override
        Widget build(BuildContext context) {
                return MaterialApp(
                    theme: ThemeData(
                    primaryColor: Colors.deepPurple[500]
                    ),
                    home: DefaultTabController(
                    
                    length: 1,
                    child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                            leading: 
                                IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                                    Navigator.of(context).pop('/');
                                    }),
                        
                            title: Text('Favorites'),
                        ),
                        body: Container(
                            child: 
                                     FutureBuilder(
                                future: getFavorites(),
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
                                                        ]),
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
          