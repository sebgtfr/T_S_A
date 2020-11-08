class UserModel {
  final String id;
  final String photoUrl;
  final String email;
  final String displayName;

  UserModel.fromJson(final String id, final Map<String, dynamic> json)
      : id = id,
        photoUrl = json['photoUrl'],
        email = json['email'],
        displayName = json['displayName'];
}
