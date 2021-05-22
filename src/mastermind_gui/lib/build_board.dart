/// @file build_board.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module that builds the layout of hints and pegs on the gameboard 
//  @date April 6, 2020

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'GameBoard.dart';

/// @brief class defines the stateless game board layout of hints and pegs
class draw_board extends StatelessWidget {
  final int row;
  draw_board(this.row, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BoardT>(
      builder: (BuildContext context, Widget child, BoardT boardT) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                boardT.clues[row * 4 + 0],
                boardT.clues[row * 4 + 1],
                boardT.buttons[row * 4 + 0],
                boardT.buttons[row * 4 + 1],
                boardT.buttons[row * 4 + 2],
                boardT.buttons[row * 4 + 3],
                boardT.clues[row* 4 + 2],
                boardT.clues[row* 4 + 3],
              ],
            ),
          )
        );
      }
    );
  } 
}