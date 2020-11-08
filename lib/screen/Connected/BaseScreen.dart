import 'package:flutter/material.dart';

import 'package:tsa_gram/screen/Connected/HomeScreen.dart';
import 'package:tsa_gram/screen/Connected/ProfileScreen.dart';
import 'package:tsa_gram/screen/PostImageScreen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentScreen = 0;

  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    PostImageScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentScreen,
        onTap: switchScreen,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
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
