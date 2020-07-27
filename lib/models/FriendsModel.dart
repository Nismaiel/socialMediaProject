class FriendsModel {
  final String name;
  final String email;
  final String id;
  final String picture;
  bool onlineStatus;

  FriendsModel({
    this.id,
    this.email,
    this.name,
    this.onlineStatus,
    this.picture,
  });

  FriendsModel.fromJson(Map<String, dynamic> parsed)
      : name = parsed['name'],
        email = parsed['email'],
        id = parsed['id'],
        picture = parsed['picture'],
        onlineStatus = parsed['online'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'picture': picture,
      'online': onlineStatus,
    };
  }
}
