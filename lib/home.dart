import 'package:flutter/material.dart';
import 'about.dart';
import 'game.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            tooltip: 'About',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return About();
              }));
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [const Color(0xFFB3E5FC), const Color(0xFF2196F3)])),
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      size: 140,
                      color: Colors.lightBlue[800],
                    ),
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 108,
                      color: Colors.lightBlue[800],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 6),
                        child: Container(
                            width: 130,
                            child: Center(
                              child: Text(
                                'vs Bot',
                                style: TextStyle(
                                    color: Colors.lightBlue[800], fontSize: 30),
                              ),
                            )),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return GamePage(true);
                          }));
                        },
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 6),
                        child: Container(
                            width: 130,
                            child: Center(
                              child: Text(
                                'vs Friend',
                                style: TextStyle(
                                    color: Colors.lightBlue[800], fontSize: 30),
                              ),
                            )),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return GamePage(false);
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
