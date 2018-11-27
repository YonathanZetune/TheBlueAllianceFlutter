
class EventStats {

    
    List<String> ccwms;
    // Map<String, double> dprs;
    // Map<String, double> oprs;
    EventStats({this.ccwms});

    factory EventStats.fromJson(Map<String, dynamic> json) {
        Map<String, dynamic> myccwms = new Map<String, dynamic>();
        if(json['ccwms'] != null){
        myccwms = json['ccwms'];
        }

        List<String> myKeysList = new List<String>();
        List<double> myKeysVal = new List<double>();
        for(var key in myccwms.keys){
            myKeysList.add(key);
            print('KEY:' + key);
        }
        for(var key in myKeysList){
            myKeysVal.add(myccwms[key]);
        }
        
        myKeysList.sort((b,a) => myccwms[a].compareTo(myccwms[b]));
        
        
        return new EventStats(ccwms: myKeysList);
    }
}
