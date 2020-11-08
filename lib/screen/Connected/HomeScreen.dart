import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/models/PostModel.dart';
import 'package:tsa_gram/models/UserModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Auth _auth = Auth();

  bool _isLoading = true;
  List<PostModel> _posts = [];

  @override
  void initState() {
    print(context);
    this.fetchPosts();
    super.initState();
  }

  Future<void> fetchPosts() {
    setState(() {
      _isLoading = true;
      _posts = List<PostModel>();
    });

    return _auth.db
        .collection('posts')
        .orderBy('createAt', descending: true)
        .get()
        .then((QuerySnapshot postQuery) {
      postQuery.docs.forEach((QueryDocumentSnapshot doc) {
        if (doc.exists) {
          final Map<String, dynamic> postData = doc.data();
          final DocumentReference userRef = postData['uploadBy'];

          userRef.get().then((DocumentSnapshot userDoc) {
            if (userDoc.exists) {
              setState(() {
                _posts.add(
                  PostModel.fromJson(
                    postData,
                    UserModel.fromJson(
                      userDoc.data(),
                    ),
                  ),
                );
              });
            }
          });
        }
      });
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return this._isLoading
        ? Container(
            child: LinearProgressIndicator(),
          )
        : Container(
            child: RefreshIndicator(
              onRefresh: () {
                return fetchPosts();
              },
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 8,
                        color: Color(0x22000000),
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(_posts[index].uploadBy.displayName),
                      SizedBox(
                        height: 5,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/img/logo.jpg'),
                          image: NetworkImage(_posts[index].photoUrl),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <InlineSpan>[
                            TextSpan(
                              text: _posts[index].uploadBy.displayName + ': ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: _posts[index].caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
