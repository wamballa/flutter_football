import 'package:flutter/material.dart';
import 'package:flutter_football_api/Screens/homescreen.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp() : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Football',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}