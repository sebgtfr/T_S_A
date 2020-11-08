import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tsa_gram/models/UserModel.dart';

class PostModel {
  PostModel(this.photoUrl, this.caption, this.location);

  PostModel.fromJson(
      this.id, final Map<String, dynamic> json, this.likes, this.uploadBy)
      : photoUrl = json['photoUrl'] as String,
        caption = json['caption'] as String,
        location = json['location'] as String,
        createAt = json['createAt'] as Timestamp;

  final String photoUrl;
  final String caption;
  final String location;

  String id;
  List<String> likes;
  Timestamp createAt;
  UserModel uploadBy;
}
