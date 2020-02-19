import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz.dart';
import 'package:quiz_app/screens/result.dart';
import 'package:quiz_app/screens/start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(37, 44, 74, 1.0),
        primaryColor: Color.fromRGBO(190, 56, 55, 1.0),
      ),
      routes: {
        'start': (context) => Start(),
        'quiz': (context) => Quiz(),
        'result': (context) => Result(),
      },
      home: Start(),
    );
  }
}