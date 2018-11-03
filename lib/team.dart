class TeamList {
  
  final List<Team> teams;
  TeamList({
    this.teams,
});

  factory TeamList.fromJson(List<dynamic> parsedJson) {

    List<Team> myTeams = new List<Team>();
    myTeams = parsedJson.map((i)=>Team.fromJson(i)).toList();

    return new TeamList(
      teams: myTeams
    );
  }
}
class Team {
final String key;
final String motto;
final String teamNum;
final String nickName;
Team({this.key, this.motto, this.teamNum, this.nickName});

factory Team.fromJson(Map<String, dynamic> json) {
  
    return new Team(
      key: json['key'],
      motto: json['name'].toString(),
      teamNum: json["team_number"].toString(),
      nickName: json['nickname']



    );
  }

}




