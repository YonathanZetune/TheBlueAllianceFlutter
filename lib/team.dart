// return a List<Team> from Json String
class TeamList {
  final List<Team> teamslist;

  TeamList({
    this.teamslist,
  });

factory TeamList.fromJson(List<dynamic> parsedJson) {

    List<Team> teams = new List<Team>();
    teams = (parsedJson).map((i)=>Team.fromJson(i)).toList();
    return new TeamList(
       teamslist: teams,
    );
  }

}

class Team {
    String key;
    String motto;
    String teamNum;
    String nickName;
    int teamInt;
    Team({this.key, this.motto, this.teamNum, this.nickName, this.teamInt});

    factory Team.fromJson(Map<String, dynamic> json) {
        var myMotto = 'FIRST Gracious Professionalism';
        if (json['motto'].toString() != 'null'){
            myMotto = json['motto'].toString();
        }
        return new Team(
            key: json['key'],
            motto: myMotto,
            teamNum: json["team_number"].toString(),
            teamInt: json["team_number"],
            nickName: json['nickname']
        );
    }
}

class TeamDetail {
    String key;
    String city;
    String name;
    String state;
    String address;
    String gmapsurl;
    String country;
    Map<String, dynamic> homechamps;
    String sponsors;
    String rookieyear;
    String teamnum;
    String website;
    TeamDetail({this.key, this.city, this.name, 
    this.state, this.address, this.country, this.gmapsurl, 
    this.homechamps, this.rookieyear, this.sponsors, this.teamnum, this.website});

    factory TeamDetail.fromJson(Map<String, dynamic> json) {
        return new TeamDetail(
            key: json['key'],
            city: json['city'],
            name: json['nickname'],
            state:json['state_prov'],
            gmapsurl: json['gmaps_url'],
            country: json['country'],
            homechamps: json['home_championship'],
            sponsors: json['name'],
            rookieyear: json['rookie_year'].toString(),
            teamnum: json['team_number'].toString(),
            website: json['website'],
            address: json['address']


        );
    }
}


