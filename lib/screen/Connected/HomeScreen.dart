import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/models/Posts/PostsProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PostsProvider>(context, listen: false).fetchAllPosts();
    super.initState();
  }

  String getTimeDiff(final Timestamp postCreatedAtTime) {
    final DateTime postCreatedAt = DateTime.fromMillisecondsSinceEpoch(
        postCreatedAtTime.millisecondsSinceEpoch);
    final Duration diff = DateTime.now().difference(postCreatedAt);

    if (diff.inSeconds < 0) {
      return '0 sec';
    } else if (diff.inSeconds < 60) {
      return '${diff.inSeconds.toString()} sec';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes.toString()} min';
    } else if (diff.inHours < 24) {
      return '${diff.inHours.toString()} hours';
    }
    return '${diff.inDays.toString()} days';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<User, PostsProvider>(builder: (BuildContext context,
        User user, PostsProvider postsProvider, Widget child) {
      return (!postsProvider.listAllPosts.isUploaded)
          ? Container(
              child: const LinearProgressIndicator(),
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  postsProvider.refreshFetchAllPosts();
                },
                child: ListView.builder(
                  itemCount: postsProvider.listAllPosts.posts.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: postsProvider
                                                  .listAllPosts
                                                  .posts[index]
                                                  .uploadBy
                                                  .photoUrl !=
                                              null
                                          ? Image(
                                              height: 50.0,
                                              width: 50.0,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(postsProvider
                                                  .listAllPosts
                                                  .posts[index]
                                                  .uploadBy
                                                  .photoUrl),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  postsProvider.listAllPosts.posts[index]
                                      .uploadBy.displayName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(getTimeDiff(postsProvider
                                    .listAllPosts.posts[index].createAt)),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_horiz),
                                  color: Colors.black,
                                  onPressed: () => print('More'),
                                ),
                              ),
                              InkWell(
                                onDoubleTap: () =>
                                    postsProvider.likePost(index, user.uid),
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
                                  margin: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: 400.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: <BoxShadow>[
                                      const BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0, 5),
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(postsProvider
                                          .listAllPosts.posts[index].photoUrl),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.favorite_border),
                                              iconSize: 30.0,
                                              onPressed: () => postsProvider
                                                  .likePost(index, user.uid),
                                            ),
                                            Text(
                                              postsProvider.listAllPosts
                                                  .posts[index].likes.length
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: postsProvider.listAllPosts
                                                    .posts[index].location !=
                                                null
                                            ? Row(
                                                children: <Widget>[
                                                  const Icon(Icons
                                                      .location_on_outlined),
                                                  Text(
                                                    postsProvider.listAllPosts
                                                        .posts[index].location,
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          postsProvider.listAllPosts
                                              .posts[index].caption,
                                          style: const TextStyle(
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
                ),
              ),
            );
    });
  }
}
