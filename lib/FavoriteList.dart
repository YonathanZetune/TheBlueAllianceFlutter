import 'package:flutter/material.dart';
import 'package:tba_application/EventPage.dart';
import 'package:tba_application/Event.dart';
import 'package:tba_application/Requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList extends StatelessWidget {
    Future<List<Event>> getFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Event> myEvents = new List<Event>();
  if (prefs.getStringList('key') != null){
  for (var key in prefs.getStringList('key')){
      myEvents.add(await Requests.getEvent(key));
  }
    return myEvents;
  }else{return null;}

}
        @override
        Widget build(BuildContext context) {
                return Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                            backgroundColor: Colors.deepPurple[500],
                            leading: 
                                IconButton(icon: Icon(Icons.arrow_back ), onPressed: (){
                                    Navigator.pop(context);
                                    }),
                        
                            title: Text('Favorites'),
                        ),
                        body: Container(
                            child: 
                                     FutureBuilder(
                                future: getFavorites(),
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                    if (snapshot.data == null || snapshot.data.length == 0){
                                        return Container(
                                            child: Center(
                                                child: Text('No Favorites')
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
                //),
            //),
        );
    }
}
          