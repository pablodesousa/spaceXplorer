const String getUserLogin = r'''
query LoginUser($username: String!, $password: String!) {
  Login(username: $username, password: $password) {
    id
    token
  } 
}
''';

const String getPlane = r'''
query launches() {
  launches {
    launches {
      id
      mission {
        missionPatch
        name
      }
      rocket {
        name
        type
      }
    }
    hasMore
    cursor
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