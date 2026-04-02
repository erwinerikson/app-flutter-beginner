import 'dart:convert';

class UserDetail {
  String? avatarUrl;
  String? htmlUrl;
  String? name;
  String? location;
  String? createdAt;
  String? followers;
  String? following;

  UserDetail({this.avatarUrl, this.htmlUrl, this.name, this.location, this.createdAt, this.followers, this.following});

  factory UserDetail.fromJson(Map<String, dynamic> map) {
    return UserDetail(
      avatarUrl: map['avatar_url'],
      htmlUrl: map['html_url'],
      name: map['name'],
      location: map['location'],
      createdAt: map['created_at'],
      followers: map['followers'].toString(),
      following: map['following'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "avatarUrl": avatarUrl,
      "htmlUrl": htmlUrl,
      "name": name,
      "location": location,
      "createdAt": createdAt,
      "followers": followers,
      "following": following
    };
  }

  @override
  String toString() {
    return 'UserDetail{avatarUrl: $avatarUrl, htmlUrl: $htmlUrl, name: $name, location: $location, createdAt: $createdAt, followers: $followers, following: $following}';
  }
}

UserDetail userDetailFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return UserDetail.fromJson(data);
}

String userToJson(UserDetail data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}