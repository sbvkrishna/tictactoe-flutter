import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

int moves = 0;
List<String> inputs = ['', '', '', '', '', '', '', '', ''];
String status = '';
String winner = '';
var lol;
var turnstate;
String turn = 'First Move: X';
void _resetGame() {
  moves = 0;
  status = '';
  inputs = ['', '', '', '', '', '', '', '', ''];
  turn = 'First Move: X';
}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    lol = this;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: <Widget>[_BoxContainer(), Status()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            awaitfn(context, 'Reset?', 'Want to reset the current game?',
                'Go Back', 'Reset');
          });
        },
        tooltip: 'Restart',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

awaitfn(BuildContext context, String title, String content, String btn1,
    String btn2) async {
  bool result = await _showAlertBox(context, title, content, btn1, btn2);
  if (result) {
    lol.setState(() {
      _resetGame();
    });
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
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
            ))));
  }
}

class Box extends StatefulWidget {
  final int index;
  Box(this.index);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  void awaitfnn() async {
    bool result = await _showAlertBox(
        context, '$winner won!', 'Start a new Game?', 'Exit', 'New Game');
    if (result) {
      lol.setState(() {
        _resetGame();
      });
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  void pressed() {
    setState(() {
      moves++;
      if (!inputs.contains('')) {
        awaitfn(context, 'It"s a Draw', 'Want to try again?', '', 'New Game');
      }
      if (_checkGame()) {
        awaitfnn();
      }
      turnstate.setState(() {
        (moves % 2 == 0) ? turn = 'Turn: X' : turn = 'Turn: O';
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
                inputs[widget.index],
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () {
          if (inputs[widget.index] == '') {
            if (moves % 2 == 0)
              inputs[widget.index] = 'X';
            else
              inputs[widget.index] = 'O';
            pressed();
          }
        });
  }
}

Future<bool> _showAlertBox(BuildContext context, String title, String content,
    String btn1, String btn2) async {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
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
