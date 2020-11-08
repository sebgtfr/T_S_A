import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/models/Posts/PostModel.dart';
import 'package:tsa_gram/models/Posts/PostsList.dart';
import 'package:tsa_gram/models/UserModel.dart';

class PostsProvider extends ChangeNotifier {
  static const String collectionName = 'posts';

  final Auth _auth = Auth();

  final PostsList _listAllPosts = PostsList();

  PostsList get listAllPosts {
    return _listAllPosts;
  }

  Future<List<PostModel>> _fetchPosts(QuerySnapshot postQuery) {
    return Future.wait(postQuery.docs.map((QueryDocumentSnapshot doc) async {
      if (doc.exists) {
        final Map<String, dynamic> postData = doc.data();
        final DocumentReference userRef =
            postData['uploadBy'] as DocumentReference;
        final DocumentSnapshot userDoc = await userRef.get();

        if (userDoc.exists) {
          final List<String> likes = <String>[];

          postData['likes'].forEach((final dynamic item) {
            likes.add(item as String);
          });

          return PostModel.fromJson(
            doc.id,
            postData,
            likes,
            UserModel.fromJson(
              userDoc.id,
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
    fetchAllPosts();
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
    return _auth.db.collection(collectionName).add(<String, dynamic>{
      'photoUrl': post.photoUrl,
      'caption': post.caption,
      'location': post.location,
      'likes': <String>[],
      'uploadBy': _auth.db.doc('users/$userUId'),
      'createAt': FieldValue.serverTimestamp(),
    });
  }

  void likePost(final int index, final String userUId) {
    final PostModel post = _listAllPosts.posts[index];
    final int indexLike = _listAllPosts.posts[index].likes.indexOf(userUId);
    FieldValue field;

    if (indexLike != -1) {
      _listAllPosts.posts[index].likes.removeAt(indexLike);
      field = FieldValue.arrayRemove(<String>[userUId]);
    } else {
      _listAllPosts.posts[index].likes.add(userUId);
      field = FieldValue.arrayUnion(<String>[userUId]);
    }
    _auth.db
        .collection(collectionName)
        .doc(post.id)
        .update(<String, dynamic>{'likes': field}).then(
            (void value) => notifyListeners());
  }
}
