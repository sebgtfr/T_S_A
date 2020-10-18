import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/common/appTheme.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';

import 'package:tsa_gram/screen/HomeScreen.dart';
import 'package:tsa_gram/screen/LoginScreen.dart';
import 'package:tsa_gram/screen/ProfileScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Auth>(
        create: (BuildContext context) => Auth(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: appTheme,
          initialRoute: '/login',
          routes: <String, Widget Function(BuildContext)>{
            '/': (BuildContext context) => HomeScreen(),
            '/login': (BuildContext context) => LoginScreen(),
            '/profile': (BuildContext context) => ProfileScreen(),
          },
        ));
  }
}
