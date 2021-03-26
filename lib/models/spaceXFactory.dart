class Mission {
  Mission({ this.name,this.missionPatch});
  factory Mission.fromJson(Map<String, dynamic> json){
    return Mission(
        name: json['name'] as String,
        missionPatch: json['missionPatch'] as String
    );
  }
  String name;
  String missionPatch;
}

class Rocket {
  Rocket({ this.name,this.type});
  factory Rocket.fromJson(Map<String, dynamic> json){
    return Rocket(
        name: json['name'] as String,
        type: json['type'] as String
    );
  }
  String name;
  String type;
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
  String avatar;
  String email;
  String username;
}

class SpaceX {
  SpaceX({ this.mission });
  factory SpaceX.fromJson(Map<String, dynamic> json){
    return SpaceX(
        mission: Mission.fromJson(json['mission'] as Map<String, dynamic>)
    );
  }
  Mission mission;
}

class SpaceXItem {
  SpaceXItem({ this.spaceX });
  factory SpaceXItem.fromJson(Map<String, dynamic> json){
    return SpaceXItem(
        spaceX: SpaceX.fromJson(json['spaceX'] as Map<String, dynamic>)
    );
  }
  SpaceX spaceX;
}

class SpaceList {
  SpaceList({
    this.spaceList,
  });

  factory SpaceList.fromJson(List<dynamic> parsedJson) {
    final List<SpaceXItem> spaceList = parsedJson.map((dynamic i)=>SpaceXItem.fromJson(i as Map<String, dynamic>)).toList();
    return SpaceList(
        spaceList: spaceList
    );
  }
  final List<SpaceXItem> spaceList;
}

class LaunchItem {
  LaunchItem({ this.missionID, this.mission, this.rocket });
  factory LaunchItem.fromJson(Map<String, dynamic> json){
    return LaunchItem(
      mission: Mission.fromJson(json['mission'] as Map<String, dynamic>),
      rocket: Rocket.fromJson(json['rocket'] as Map<String, dynamic>),
      missionID: json['id'] as int,
    );
  }
  final int missionID;
  final Mission mission;
  final Rocket rocket;
}

class LaunchList {
  LaunchList({
    this.launchList,
  });

  factory LaunchList.fromJson(List<dynamic> parsedJson) {
    final List<LaunchItem> launchList = parsedJson.map((dynamic i)=>LaunchItem.fromJson(i as Map<String, dynamic>)).toList();
    return LaunchList(
        launchList: launchList
    );
  }
  final List<LaunchItem> launchList;
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
