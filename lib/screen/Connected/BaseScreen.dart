import 'package:flutter/material.dart';

import 'package:tsa_gram/screen/Connected/AddScreen.dart';
import 'package:tsa_gram/screen/Connected/FavoriteScreen.dart';
import 'package:tsa_gram/screen/Connected/HomeScreen.dart';
import 'package:tsa_gram/screen/Connected/ProfileScreen.dart';
import 'package:tsa_gram/screen/Connected/SearchScreen.dart';
import 'package:tsa_gram/screen/PostImageScreen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentScreen = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void switchScreen(int index) {
    setState(() {
      _currentScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('TSA Gram'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Take a picture',
            icon: Icon(Icons.camera),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostImageScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentScreen,
        onTap: switchScreen,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentScreen]),
    );
  }
}
