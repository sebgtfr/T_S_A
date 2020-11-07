class UserModel {
  final String photoUrl;
  final String email;
  final String displayName;

  UserModel.fromJson(Map<String, dynamic> json)
      : photoUrl = json['photoUrl'],
        email = json['email'],
        displayName = json['displayName'];
}
