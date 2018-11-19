class MatchList {
  final List<Match> matchlist;
  MatchList({
    this.matchlist,
  });
factory MatchList.fromJson(List<dynamic> parsedJson) {
    List<Match> matches = new List<Match>();
    matches = (parsedJson).map((i)=>Match.fromJson(i)).toList();
    return new MatchList(
       matchlist: matches,
    );
  }

}
class Match {
   static getCompLevel(String compL, String matchNum, String setNum){
        return compL.toUpperCase() + '\n' + matchNum + '-' + setNum;
        
    }
    int time;
    String winningalliance;
    String complevel;
    List<ColorAlliance> alliances;
    Match({this.time, this.winningalliance, this.complevel, this.alliances});

    factory Match.fromJson(Map<String, dynamic> json) {
        var newtime = json['time'];
        if (newtime == null){
            newtime = 0;
        }
        
        return new Match(
            time: newtime,
            winningalliance: json['winning_alliance'],
            complevel: getCompLevel(json["comp_level"], json["match_number"].toString(), json['set_number'].toString()),
            alliances: Alliances.fromJson(json["alliances"]).allianceList
        );
    }
}
class Alliances{
    List<ColorAlliance> allianceList;

    Alliances({this.allianceList});
    
    factory Alliances.fromJson(Map<String, dynamic> jsons) {
        List<ColorAlliance> allList = new List<ColorAlliance>();
        allList.add(ColorAlliance.fromJson(jsons['red']));
        allList.add(ColorAlliance.fromJson(jsons['blue']));
        
        return new Alliances(
            allianceList: allList
        );
    }
}
class ColorAlliance{
    int score;
    List<dynamic> teamkeys;
    ColorAlliance({this.score, this.teamkeys});

    factory ColorAlliance.fromJson(Map<String, dynamic> json) {
        List<String> listkeys = new List<String>();
        for (var key in json["team_keys"]){
            listkeys.add(key.toString());
        }
        return new ColorAlliance(
            score: json['score'],
            teamkeys: listkeys,

        );
    }
}
