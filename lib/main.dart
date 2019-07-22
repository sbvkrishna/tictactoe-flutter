import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        //fontFamily: ''
      ),
      home: HomePage(),
    );
  }
}

