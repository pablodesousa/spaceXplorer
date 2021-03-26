const String bookATrip = r'''
mutation bookATrip($launch_id: Int!) {
  bookTrip(launch_id: $launch_id) {
    launch_id
    user_id
  }
}
''';

const String uploadAvatar = r'''
mutation uploadAvatar($base64str: String!, $name: String!, $type: String!) {
  uploadAvatar(base64str: $base64str, name: $name, type: $type) {
    avatar
  }
}
''';

const String signUpUser = r'''
mutation Signup($username: String!, $password: String!, $email: String!) {
  Signup(email: $email, password: $password, username: $username) {
    id
    token
  }
}
''';