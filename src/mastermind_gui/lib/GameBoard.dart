/// @file GameBoard.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module that defines the game board data type. 
//  @date April 6, 2020

import 'ButtonT.dart';
import 'GameTypes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

///  @brief class represents the game board
class BoardT extends Model {
  List<ButtonT> buttons;
  List<ButtonT> clues;
  List<Color> password;
  int currButton;
  int currClue;

  ///  @brief Initializes the game board with a random secret code
  BoardT(){
    buttons = List(40);
    clues = List(40);
    password = List(4);

    for (var i = 0; i < 40; i++){
      buttons[i] = ButtonT(color: Colors.grey, size: 40);
    }

    for (var i = 0; i < 40; i++){
      clues[i] = ButtonT(color: Colors.grey, size: 10);
    }

    // generates a new Random object
    final _random = new Random();

    // generate a random index based on the list length
    // and use it to retrieve the element
    password[0] = ColourT[_random.nextInt(ColourT.length)];
    password[1] = ColourT[_random.nextInt(ColourT.length)];
    password[2] = ColourT[_random.nextInt(ColourT.length)];
    password[3] = ColourT[_random.nextInt(ColourT.length)];

    currButton = 0;
    currClue = 0;
  }

  /// @brief Adds a guess to the game board
  //  @param button - a guess of type ButtonT
  void add_button (ButtonT button){
    buttons[currButton] = button;
    currButton++;
    if(currButton%4 == 0) {
      draw_hints();

    }
    notifyListeners();
  }

  /// @brief Method to undo a guess if allowed
  void undo_move(){
    if(currButton % 4 != 0 && currButton != 0){
      buttons[currButton-1] = ButtonT(color: Colors.grey, size: 40);
      currButton--;
    }
    notifyListeners();
  }
  
  /// @brief Method add a clue
  void add_clue (ButtonT clue) {
    clues[currClue] = clue;
    currClue++;
    
    notifyListeners();
  }

  /// @brief Method to retrieve the list of buttons
  //  @return list of buttons of type ButtonT
  List<ButtonT> get get_buttons{
    return buttons;
  }

  /// @brief Method to retrieve the list of clues
  //  @return list of clues of type ButtonT
  List<ButtonT> get get_clues{
    return clues;
  }

  /// @brief Method to retrieve the secret password
  //  @return ordered list of type Color
  List<Color> get get_password{
    return password;
  }

  /// @brief Method to validate a guess
  //  @return True if the guess corresponds to the password. False otherwise.
  bool get check_win{
    if (currButton%4 ==0 ) {
    if (  clues[currClue-1].getColor == Colors.green &&
          clues[currClue-2].getColor == Colors.green &&
          clues[currClue-3].getColor == Colors.green &&
          clues[currClue-4].getColor == Colors.green ) {
            return true;
          } }
    return false;
  }

  /// @brief Method to check if the game has been lost
  //  @return True if the last guess of the game is wrong. False otherwise.
  bool get check_lose{
    if (!check_win && currButton == 40) {
      return true;
    }
    return false;
  }

  /// @brief Method to determine the 4 hint types of ClueT for a guess of 4 ButtonT
  void draw_hints() {
    List<bool> gridCheck = new List<bool>.filled(4, false);
    List<bool> colorCheck = new List<bool>.filled(4,false);

    for (var i = 0; i < 4; i++){
      if(buttons[currButton-4+i].getColor == password[i]) {
        gridCheck[i] = true;
        colorCheck[i] = true;
        add_clue( ButtonT(color: Colors.green, size: 10));
      }
    }
    for (var i = 0; i < 4; i++){
      if (gridCheck[i]) continue;
      for (var j = 0; j < 4; j++) {
        if (i == j || colorCheck[j] ) continue;
        if (buttons[currButton-4+i].getColor == password[j]) {
          colorCheck[j] = true;
          add_clue( ButtonT(color: Colors.yellow, size: 10));
          break;
        }
      }
    }
    while (currClue != currButton) {
      add_clue(ButtonT(color: Colors.red, size: 10));
    }
  }
}