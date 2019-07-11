import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Me"),
        ),
        body: aboutBody);
  }
}

Widget get aboutBody {
  return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'A Simple TicTacToe game made using Flutter!',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Developed by Krishna S',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.code),
                    Text(
                      '  Github: sbvkrishna',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Text(
                      '  saladibalavijayakrishna@gmail.com',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ));
}
