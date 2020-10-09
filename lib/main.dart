import 'package:flutter/material.dart';
import 'package:tutorial/widgets/splash_screen.dart';
import 'package:tutorial/widgets/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reveal Tutorial',
      theme: ThemeData(
        primaryColor: Colors.green[300],
        accentColor: Colors.green[900],
      ),
      home: SplashScreen(
        seconds: 1,
        navigateAfterSeconds: MyHomePage(title: "Reveal Tutorial"),
        title: new Text('Reveal Tutorial'),
        image: new Image.asset('assets/icon-eucalyptus.png'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}