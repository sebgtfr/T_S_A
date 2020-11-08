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
        .orderBy('createAt', descending: false)
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
        ? Container(child: LinearProgressIndicator())
        : Container(
            child: RefreshIndicator(
              onRefresh: () {
                return fetchPosts();
              },
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  child: ClipOval(
                                      /*child: Image(
                                    height: 50.0,
                                    width: 50.0,
                                    image: NetworkImage(_posts[index].photoUrl),
                                    // ** OLD ** image: AssetImage
                                    (posts[index].authorImageUrl),
                                    fit: BoxFit.cover,
                                  ),*/
                                      ),
                                ),
                              ),
                              title: Text(
                                // posts[index].authorName,
                                'Pseudo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('10 min'),
                              // Text(posts[index].timeAgo)
                              trailing: IconButton(
                                icon: Icon(Icons.more_horiz),
                                color: Colors.black,
                                onPressed: () => print('More'),
                              ),
                            ),
                            InkWell(
                              onDoubleTap: () => print('Like post'),
                              onTap: () {
                                /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewPostScreen(
                                    post: posts[index],
                                  ),
                                ),
                              );*/
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                width: double.infinity,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0, 5),
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(_posts[index].photoUrl),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      iconSize: 30.0,
                                      onPressed: () => print('Like post'),
                                    ),
                                    Text(
                                      '2,515 (nb like !)',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // child: ListView.builder(
                //   itemCount: _posts.length,
                //   itemBuilder: (BuildContext context, int index) => Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       boxShadow: <BoxShadow>[
                //         BoxShadow(
                //           blurRadius: 8,
                //           color: Color(0x22000000),
                //           offset: Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 10,
                //       vertical: 10,
                //     ),
                //     margin: EdgeInsets.symmetric(
                //       horizontal: 5,
                //       vertical: 5,
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           _posts[index].uploadBy.displayName,
                //           style: Theme.of(context)
                //               .primaryTextTheme
                //               .headline1
                //               .copyWith(fontSize: 14),
                //         ),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         ClipRRect(
                //           borderRadius: BorderRadius.circular(8),
                //           child: FadeInImage(
                //             placeholder: AssetImage('assets/img/logo.jpg'),
                //             image: NetworkImage(_posts[index].photoUrl),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         RichText(
                //           softWrap: true,
                //           text: TextSpan(
                //             style: TextStyle(color: Colors.black),
                //             children: <InlineSpan>[
                //               TextSpan(
                //                 text: _posts[index].uploadBy.displayName + ': ',
                //                 style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //               TextSpan(
                //                 text: _posts[index].caption,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ),
          );
  }
}
