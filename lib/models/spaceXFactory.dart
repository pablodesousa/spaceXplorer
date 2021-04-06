class Planet {
  Planet({ this.picture, this.name, this.score });
  factory Planet.fromJson(Map<String, dynamic> json){
    return Planet(
      picture: json['picture_url'] as String,
      name: json['planet_name'] as String,
      score: json['score'] as int,
    );
  }
  final String picture;
  final String name;
  final int score;
}

class MissionItem {
  MissionItem({ this.launchDate, this.rocketName, this.startHour, this.endHour, this.picture, this.id, this.planet });
  factory  MissionItem.fromJson(Map<String, dynamic> json){
    return  MissionItem(
      planet: Planet.fromJson(json['planet'] as Map<String, dynamic>),
      id: json['id'] as int,
      launchDate: json['launch_date'] as String,
      picture: json['picture_url'] as String,
      rocketName: json['rocket_name'] as String,
      startHour: json['start_hour'] as int,
      endHour: json['end_hour'] as int,
    );
  }
  final int id;
  final String launchDate;
  final String rocketName;
  final String picture;
  final int startHour;
  final int endHour;
  final Planet planet;
}

class MissionList {
  MissionList({
    this.missionItem,
  });

  factory MissionList.fromJson(List<dynamic> parsedJson) {
    final List<MissionItem> missionItem = parsedJson.map((dynamic i)=>MissionItem.fromJson(i as Map<String, dynamic>)).toList();
    return MissionList(
        missionItem: missionItem
    );
  }
  final List<MissionItem> missionItem;
}

class Profile {
  Profile({ this.avatar, this.email, this.username});
  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
        avatar: json['avatar'] as String,
        email: json['email'] as String,
        username: json['username'] as String
    );
  }
  final String avatar;
  final String email;
  final String username;
}

class ProfileList {
  ProfileList({
    this.profileItem,
  });

  factory ProfileList.fromJson(List<dynamic> parsedJson) {
    final List<Profile> profileItem = parsedJson.map((dynamic i)=>Profile.fromJson(i as Map<String, dynamic>)).toList();
    return ProfileList(
        profileItem: profileItem
    );
  }
  final List<Profile> profileItem;
}

class LeaderUser {
  LeaderUser({ this.avatar, this.username});
  factory LeaderUser.fromJson(Map<String, dynamic> json){
    return LeaderUser(
      avatar: json['avatar'] as String,
      username: json['username'] as String,
    );
  }
  final String avatar;
  final String username;
}

class Leader {
  Leader({ this.totalScore, this.user });
  factory Leader.fromJson(Map<String, dynamic> json){
    return Leader(
        totalScore: json['total_score'] as int,
        user: LeaderUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
  final int totalScore;
  final LeaderUser user;
}

class LeaderList {
  LeaderList({
    this.leaderItem,
  });

  factory LeaderList.fromJson(List<dynamic> parsedJson) {
    final List<Leader> leaderItem = parsedJson.map((dynamic i)=>Leader.fromJson(i as Map<String, dynamic>)).toList();
    return LeaderList(
        leaderItem: leaderItem
    );
  }
  final List<Leader> leaderItem;
}


