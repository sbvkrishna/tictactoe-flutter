import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'A Simple TicTacToe game made using ',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              TextSpan(
                  text: 'Flutter',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://flutter.dev');
                    })
            ]),
          ),
          Container(
            height: 150,
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
                    InkWell(
                      child: Text(
                        '  Github: sbvkrishna',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      onTap: () =>
                          {launch('https://www.github.com/sbvkrishna')},
                    )
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
                Text(''),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'This Game"s Source code is available at ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextSpan(
                        text: 'Github',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.github.com/sbvkrishna/tictactoe');
                          })
                  ]),
                ),
              ],
            ),
          )
        ],
      ));
}
