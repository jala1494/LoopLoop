import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home/home_screen.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21)),
      home: HomePage(),
    );
  }
}

class Time {
  int work;
  int rest;
  int times;
  Time(this.work, this.rest, this.times);
}
