import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

int moves = 0;
List<String> inputs = ['', '', '', '', '', '', '', '', ''];
String status = '';
String winner = '';
var lol;
var turnstate;
var temp;
String turn = 'First Move: X';
bool loading = false;
bool vsBot;

class GamePage extends StatefulWidget {
  bool isBot;
  GamePage(this.isBot) {
    _resetGame();
    vsBot = this.isBot;
  }
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    lol = this;
    return Scaffold(
      appBar: AppBar(
        //leading: Container(width: 0,height: 0,),
        title: Text(vsBot?'Playing vs Bot':'Playing vs Friend'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.settings_brightness),
          //   tooltip: 'Change Theme',
          //   onPressed: () {
          //   },
          // ),
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
        decoration: BoxDecoration(color: Colors.blue[200]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_BoxContainer(), Status()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            awaitfn('Reset?', 'Want to reset the current game?', 'Go Back',
                'Reset');
          });
        },
        tooltip: 'Restart',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    temp = context;
    return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.blue),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue[100],
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                  offset: Offset(7.0, 7.0))
            ]),
        child: Center(
            child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Box(index);
          }),
        )));
  }
}

class Box extends StatefulWidget {
  final int index;
  Box(this.index);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  void pressed() {
    setState(() {
      moves++;
      if (_checkGame()) {
        awaitfnn();
      }
      else if(moves==9){
        awaitfn('It\'s a Draw', 'Want to try again?', 'Go Back', 'New Game');
      }
      turnstate.setState(() {
        if (moves % 2 == 0)
          turn = 'Turn: X';
        else
          turn = 'Turn: O';
        lol.setState(() {});
      });
    });
  }

  @override
  Widget build(context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(color: Colors.blue)),
            child: Center(
              child: Text(
                inputs[widget.index].toUpperCase(),
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () {
          if (inputs[widget.index] == '') {
            if (vsBot == false) {
              if(moves%2==0) inputs[widget.index] = 'x';
              else inputs[widget.index] = 'o';
              
            } else if (!loading) {
              loading = true;
              inputs[widget.index] = 'x';
              gameAPI();
            }
            //print(vsBot);
            pressed();
          }
        });
  }
}

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    turnstate = this;
    return Card(
        margin: EdgeInsets.all(40),
        child: Container(
          width: 220,
          height: 60,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            turn,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

//-------------------------------------TicTacToe game fns ---------------------------

bool _checkGame() {
  for (int i = 0; i < 9; i += 3) {
    if (inputs[i] != '' &&
        inputs[i] == inputs[i + 1] &&
        inputs[i + 1] == inputs[i + 2]) {
      winner = inputs[i];
      return true;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (inputs[i] != '' &&
        inputs[i] == inputs[i + 3] &&
        inputs[i + 3] == inputs[i + 6]) {
      winner = inputs[i];
      return true;
    }
  }
  if (inputs[0] != '' && (inputs[0] == inputs[4] && inputs[4] == inputs[8]) ||
      (inputs[2] != '' && inputs[2] == inputs[4] && inputs[4] == inputs[6])) {
    winner = inputs[4];
    return true;
  }
  return false;
}

void _resetGame() {
  moves = 0;
  status = '';
  inputs = ['', '', '', '', '', '', '', '', ''];
  turn = 'First Move: X';
  loading = false;
}
//------------------------------ Alerts Dialog --------------------------------------

void awaitfnn() async {
  bool result = await _showAlertBox(
      temp, '$winner won!', 'Start a new Game?', 'Exit', 'New Game');
  if (result) {
    lol.setState(() {
      _resetGame();
    });
  } else {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

Future<bool> _showAlertBox(BuildContext context, String title, String content,
    String btn1, String btn2) async {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext temp) => AlertDialog(
            title: Text(title.toUpperCase()),
            content: Text(content),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text(btn1),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              RaisedButton(
                color: Colors.white,
                child: Text(btn2),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          ));
}

awaitfn(String title, String content, String btn1, String btn2) async {
  bool result = await _showAlertBox(temp, title, content, btn1, btn2);
  if (result) {
    lol.setState(() {
      _resetGame();
    });
  }
}

//---------------------------------------- API ----------------------------------

Future gameAPI() async {
  var url = 'http://perfecttictactoe.herokuapp.com/api/v2/play';
  Map data = {
    "player_piece": "o",
    "opponent_piece": "x",
    "board": [
      {"id": "top-left", "value": inputs[0]},
      {"id": "top-center", "value": inputs[1]},
      {"id": "top-right", "value": inputs[2]},
      {"id": "middle-left", "value": inputs[3]},
      {"id": "middle-center", "value": inputs[4]},
      {"id": "middle-right", "value": inputs[5]},
      {"id": "bottom-left", "value": inputs[6]},
      {"id": "bottom-center", "value": inputs[7]},
      {"id": "bottom-right", "value": inputs[8]}
    ]
  };
  var res = await http.post(url, body: json.encode(data));
  if (res.statusCode == 200) {
    var resBody = json.decode(res.body);
    if (resBody['status'] == 'success') {
      var newBoard = resBody['data'];
      if (newBoard['status'] == 'win') {
        winner = newBoard['winner'];
        awaitfnn();
      } else if (newBoard['status'] == 'draw') {
        awaitfn('It"s a Draw', 'Want to try again?', 'Go Back', 'New Game');
      }
      int i = 0;
      newBoard['board'].forEach((box) => {inputs[i++] = box['value']});
    }
    lol.setState(() {});
    loading = false;
    turnstate.setState(() {
      turn = 'Turn: X';
      moves++;
    });
  }
}
