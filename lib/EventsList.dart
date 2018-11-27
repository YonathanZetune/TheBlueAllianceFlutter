import 'package:flutter/material.dart';
import 'package:tba_application/EventPage.dart';
import 'package:tba_application/Requests.dart';

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
                        backgroundColor: Colors.white,
                        appBar: AppBar(
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
          