// return a List<Team> from Json String
class Team {
    String key;
    String motto;
    String teamNum;
    String nickName;

    Team({this.key, this.motto, this.teamNum, this.nickName});

    factory Team.fromJson(Map<String, dynamic> json) {
        return new Team(
            key: json['key'],
            motto: json['name'],
            teamNum: json["team_number"],
            nickName: json['nickname']
        );
    }
}




