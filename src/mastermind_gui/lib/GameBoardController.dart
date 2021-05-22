/// @file GameBoardController.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module that controls the state of the game board.
//  @date April 6, 2020

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mastermind_gui/GameTypes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'build_board.dart';
import 'ButtonT.dart';
import 'GameBoard.dart';

/// @brief class to launch the game board screen
class gameBoard extends StatefulWidget {
  @override
  _gameBoardState createState() => _gameBoardState();
}

/// @brief class defined the state of the contents on the gameboard
class _gameBoardState extends State<gameBoard> {
  final gameboard = BoardT();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mastermind',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/wood.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child:  Column(
          children: <Widget>[
            ScopedModel<BoardT>(child: Controller(), model: gameboard),
          ],
        )));
  }

}

/// @brief class defines the Controller widget
class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

/// @brief class defines the container used to build the board to the screen
class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        draw_board(9),
        draw_board(8),
        draw_board(7),
        draw_board(6),
        draw_board(5),
        draw_board(4),
        draw_board(3),
        draw_board(2),
        draw_board(1),
        draw_board(0),
        undoButton(),
        secretCode()
      ],
    ));
  }
}

/// @brief class defines the undo button
class undoButton extends StatefulWidget {
  @override
  _undoButtonState createState() => _undoButtonState();
}

/// @brief class defines the state and action of the undo button
class _undoButtonState extends State<undoButton> {
  var board;
  @override
  void initState() {
    super.initState();
    board = ScopedModel.of<BoardT>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.8,0.0),
      child: RaisedButton.icon(
        onPressed: (){ board.undo_move();        
        }, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        icon: Icon(Icons.undo), 
        label: Text(""),
        ),
      
    );
  }
}

/// @brief class defines the secret code
class secretCode extends StatefulWidget {
  @override
  _secretCodeState createState() => _secretCodeState();
}

/// @brief class defines the state of the secret code and displays output based on the game state
class _secretCodeState extends State<secretCode> {
  List<Color> colourCode = ColourT;
  var board;
  @override
  void initState() {
    super.initState();
    board = ScopedModel.of<BoardT>(context);
  }

  /// @brief Widget defines the popup box for a winning game state
  Widget _winscreen(BuildContext context) {
    // flutter defined function
        // return object of type Dialog
        return new AlertDialog(
          title: new Text("YOU WIN!", textAlign: TextAlign.center),
          content: new Text("Congratulations! You have cracked the code. Do you think you can win again?", textAlign: TextAlign.center),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    }

  /// @brief Widget defines the popup box for a losing game state
  Widget _losescreen(BuildContext context) {
    // flutter defined function
        // return object of type Dialog
        return new AlertDialog(
          title: new Text("YOU LOSE!",textAlign: TextAlign.center),
          content: Container (
            height: 80,

            child: Column(
            children: <Widget> [
              Text("The correct sequence is:\n"),
              Row(
                children: <Widget> [
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                      color: board.get_password[0],
                      shape: BoxShape.circle,
                      border: Border.all()
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                      color: board.get_password[1],
                      shape: BoxShape.circle,
                      border: Border.all()
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                      color: board.get_password[2],
                      shape: BoxShape.circle,
                      border: Border.all()
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                      color: board.get_password[3],
                      shape: BoxShape.circle,
                      border: Border.all()
                    )))])])),         
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    }


  /// @brief Widget defines the user input buttons and corresponding actions
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[0], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[0]),
                  ),
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[1], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[1])
                  ),
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[2], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[2])
                  ),
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[3], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[3])
                  ),
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[4], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[4])
                  ),
          Expanded(
              child: RaisedButton(
                  onPressed: () {
                      board.add_button(ButtonT(color: colourCode[5], size: 40));
                      if (board.check_win) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _winscreen(context),
                        );
                      }
                      else if (board.check_lose) {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) => _losescreen(context),
                        );
                      }
                  },
                  color: colourCode[5])
                  ),
          
        ],
      ),
    );
  }
}
