import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halal_food_user_app/Ui/Screens/home_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/splash_screen.dart';

import 'Helpers/auth_state_handler.dart';
import 'Helpers/botttom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() {
    UserLoginStateHandler.getUserLoggedInSharedPreference().then((value) {
      if (value == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = value;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: isLoggedIn ? Bottomnavigation() : SplashScreen());
  }
}
