import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/common/appTheme.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
//import 'package:tsa_gram/models/Posts/PostsList.dart';
import 'package:tsa_gram/models/Posts/PostsProvider.dart';
import 'package:tsa_gram/models/Uploader.dart';

import 'package:tsa_gram/widgets/AppRouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: Auth().user),
        ChangeNotifierProvider(
          create: (BuildContext context) => PostsProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Uploader(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TSA_Gram',
        theme: appTheme,
        home: AppRouter(),
      ),
    );
  }
}
