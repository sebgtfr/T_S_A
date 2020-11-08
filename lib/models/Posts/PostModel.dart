import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tsa_gram/models/UserModel.dart';

class PostModel {
  PostModel(this.photoUrl, this.caption, this.location);

  String id;
  final String photoUrl;
  final String caption;
  final String location;
  List<String> likes;
  Timestamp createAt;
  UserModel uploadBy;

  PostModel.fromJson(
      final String id, final Map<String, dynamic> json, final UserModel user)
      : id = id,
        photoUrl = json['photoUrl'],
        caption = json['caption'],
        location = json['location'],
        likes = new List<String>.from(json['likes'] ?? []),
        createAt = json['createAt'],
        uploadBy = user;
}
