import 'dart:convert';

class User {
  String login;
  String avatarUrl;
  String htmlUrl;

  User({required this.login, required this.avatarUrl, required this.htmlUrl});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(login: map['login'], avatarUrl: map['avatar_url'], htmlUrl: map['html_url']);
  }

  Map<String, dynamic> toJson() {
    return {"login": login, "avatarUrl": avatarUrl, "htmlUrl": htmlUrl};
  }

  @override
  String toString() {
    return 'User{login: $login, avatarUrl: $avatarUrl, htmlUrl: $htmlUrl}';
  }
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data['items'].map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}