import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/models/Posts/PostModel.dart';
import 'package:tsa_gram/models/Posts/PostsList.dart';
import 'package:tsa_gram/models/UserModel.dart';

class PostsProvider extends ChangeNotifier {
  static const String collectionName = "posts";

  final Auth _auth = Auth();

  PostsList _listAllPosts = PostsList();

  PostsList get listAllPosts {
    return _listAllPosts;
  }

  Future<List<PostModel>> _fetchPosts(QuerySnapshot postQuery) {
    return Future.wait(postQuery.docs.map((QueryDocumentSnapshot doc) async {
      if (doc.exists) {
        final Map<String, dynamic> postData = doc.data();
        final DocumentReference userRef = postData['uploadBy'];
        final DocumentSnapshot userDoc = await userRef.get();

        if (userDoc.exists) {
          return PostModel.fromJson(
            postData,
            UserModel.fromJson(
              userDoc.data(),
            ),
          );
        }
      }
      return null;
    }));
  }

  void refreshFetchAllPosts() {
    _listAllPosts.isUploaded = false;
    _listAllPosts.posts.clear();
    notifyListeners();
    this.fetchAllPosts();
  }

  void fetchAllPosts() {
    _auth.db
        .collection(collectionName)
        .orderBy('createAt', descending: true)
        .get()
        .then(_fetchPosts)
        .then((List<PostModel> posts) {
      _listAllPosts.posts = posts;
      _listAllPosts.isUploaded = true;
      notifyListeners();
    });
  }

  Future<DocumentReference> addPost(
      final PostModel post, final String userUId) {
    return _auth.db.collection(collectionName).add({
      'photoUrl': post.photoUrl,
      'caption': post.caption,
      'location': post.location,
      'likes': List<String>(),
      'uploadBy': _auth.db.doc("users/" + userUId),
      'createAt': FieldValue.serverTimestamp(),
    });
  }
}
