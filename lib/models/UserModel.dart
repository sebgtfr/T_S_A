class UserModel {
  UserModel.fromJson(this.id, final Map<String, dynamic> json)
      : photoUrl = json['photoUrl'] as String,
        email = json['email'] as String,
        displayName = json['displayName'] as String;

  final String id;
  final String photoUrl;
  final String email;
  final String displayName;
}
