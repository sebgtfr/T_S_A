import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsa_gram/models/UserModel.dart';

class PostModel {
  final String photoUrl;
  final String caption;
  final Timestamp createAt;
  final UserModel uploadBy;

  PostModel.fromJson(Map<String, dynamic> json, final UserModel user)
      : photoUrl = json['photoUrl'],
        caption = json['caption'],
        createAt = json['createAt'],
        uploadBy = user;
}
