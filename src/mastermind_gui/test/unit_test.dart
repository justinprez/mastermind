/// @file unit_test.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module for unit testing Mastermind.
//  @date April 6, 2020

import 'package:flutter_test/flutter_test.dart';
import 'package:mastermind_gui/GameBoard.dart';
import 'package:mastermind_gui/ButtonT.dart';
import 'package:flutter/material.dart';

void main(){
  test('test-GL 1: Full peg row', (){

    // setup 
    var board = new BoardT();
    var button1 = new ButtonT(color: Colors.red, size: 10);
    var button2 = new ButtonT(color: Colors.blue, size: 10);
    var button3 = new ButtonT(color: Colors.green, size: 10);
    var button4 = new ButtonT(color: Colors.yellow, size: 10);
    var button5 = new ButtonT(color: Colors.white, size: 10);

    //run
    board.add_button(button1);
    board.add_button(button2);
    board.add_button(button3);
    board.add_button(button4);
    board.add_button(button5);

    //verify
    expect(board.buttons[0].color, Colors.red);
    expect(board.buttons[1].color, Colors.blue);
    expect(board.buttons[2].color, Colors.green);
    expect(board.buttons[3].color, Colors.yellow);
    expect(board.buttons[4].color, Colors.white);
  });


    test('test-GL 2: Test incorrect guess', (){

    // setup 
    var board = new BoardT();
    var button1 = new ButtonT(color: Colors.red, size: 10);
    var button2 = new ButtonT(color: Colors.blue, size: 10);
    var button3 = new ButtonT(color: Colors.green, size: 10);
    var button4 = new ButtonT(color: Colors.white, size: 10);
    var button5 = new ButtonT(color: Colors.white, size: 10);

    //run
    board.password[0] = Colors.red;
    board.password[1] = Colors.blue;
    board.password[2] = Colors.green;
    board.password[3] = Colors.yellow;
    board.add_button(button1);
    board.add_button(button2);
    board.add_button(button3);
    board.add_button(button4);
    board.add_button(button5);

    //verify
    expect(board.clues[0].color, Colors.green);
    expect(board.clues[1].color, Colors.green);
    expect(board.clues[2].color, Colors.green);
    expect(board.clues[3].color, Colors.red);

  });

  test('test-GL 3: Test win game', (){

    // setup 
    var board = new BoardT();
    var button1 = new ButtonT(color: Colors.red, size: 10);
    var button2 = new ButtonT(color: Colors.blue, size: 10);
    var button3 = new ButtonT(color: Colors.green, size: 10);
    var button4 = new ButtonT(color: Colors.yellow, size: 10);

    //run
    board.password[0] = Colors.red;
    board.password[1] = Colors.blue;
    board.password[2] = Colors.green;
    board.password[3] = Colors.yellow;
    board.add_button(button1);
    board.add_button(button2);
    board.add_button(button3);
    board.add_button(button4);

    //verify
    expect(board.clues[0].color, Colors.green);
    expect(board.clues[1].color, Colors.green);
    expect(board.clues[2].color, Colors.green);
    expect(board.clues[3].color, Colors.green);
    expect(board.check_win, true);

  });

    test('test-GL 4: Test lose state', (){

    // setup 
    var board = new BoardT();
    var button1 = new ButtonT(color: Colors.red, size: 10);

    //run
    board.password[0] = Colors.red;
    board.password[1] = Colors.blue;
    board.password[2] = Colors.green;
    board.password[3] = Colors.yellow;

    for (int i = 0; i < 40; i++){
      board.add_button(button1);
    }

    //verify
    expect(board.check_win, false);
    expect(board.check_lose, true);

  });

}