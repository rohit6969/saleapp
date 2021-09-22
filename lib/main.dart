import 'dart:async';

import 'package:Sale_App/userScreens/login.dart';
import 'package:flutter/material.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => AppRoot();
}

class AppRoot extends StatefulWidget {
  @override
  AppRootState createState() => AppRootState();
}

class ContextClass {
  static BuildContext context;
}

class AppRootState extends State<AppRoot> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(days: 10), (_) => _logOutUser);
  }

  void _logOutUser() {
    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in

    _timer.cancel();
    Navigator.pushAndRemoveUntil(
        ContextClass.context,
        MaterialPageRoute(builder: (BuildContext context) => BTSLogin()),
        ModalRoute.withName('/'));
  }

  // You'll probably want to wrap this function in a debounce
  void _handleUserInteraction([_]) {
    if (!_timer.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer.cancel();
    _initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    ContextClass.context = context;
    return GestureDetector(
        onTap: _handleUserInteraction,
        onPanDown: _handleUserInteraction,
        onScaleStart: _handleUserInteraction,
        // ... repeat this for all gesture events
        child: MaterialApp(
          title: 'Live Sale',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BTSLogin(),
        ));
  }
}
