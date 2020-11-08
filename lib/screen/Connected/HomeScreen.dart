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

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(builder:
        (BuildContext context, PostsProvider postsProvider, Widget child) {
      return (!postsProvider.listAllPosts.isUploaded)
          ? Container(
              child: LinearProgressIndicator(),
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  postsProvider.refreshFetchAllPosts();
                },
                child: ListView.builder(
                  itemCount: postsProvider.listAllPosts.posts.length,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(postsProvider
                            .listAllPosts.posts[index].uploadBy.displayName),
                        SizedBox(
                          height: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/img/logo.jpg'),
                            image: NetworkImage(postsProvider
                                .listAllPosts.posts[index].photoUrl),
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
                                text: postsProvider.listAllPosts.posts[index]
                                        .uploadBy.displayName +
                                    ': ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: postsProvider
                                    .listAllPosts.posts[index].caption,
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
    });
  }
}
