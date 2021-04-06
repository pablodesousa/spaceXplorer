const String getUserLogin = r'''
query LoginUser($username: String!, $password: String!) {
  Login(username: $username, password: $password) {
    id
    token
  } 
}
''';

const String getPlane = r'''
query launches {
  my_trips {
    id
    launch_date
    rocket_name
    start_hour
    end_hour
    picture_url
    planet {
      picture_url
      planet_name
      score
    }
  }
}
''';

const String getTrip = r'''
query AllTrip() {
  trips {
    spaceX {
      mission {
        missionPatch
        name
      }
    }
  }
}
''';

const String getMission = r'''
query launches($id: Int!) {
  launch(id: $id) {
    id
    mission {
      missionPatch
      name
    }
    rocket {
      name
      type
    }
    site
  }
}
''';

const String getProfile = r'''
query user() {
  user {
    avatar
    email
    username
  }
}
''';

const String getLeaderBoard = r'''
query leaderboard() {
  leaderboard(order_by: {total_score: desc}) {
    total_score
    user {
      avatar
      username
    }
  }
}
''';