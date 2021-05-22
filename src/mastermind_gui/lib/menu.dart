/// @file menu.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module for loading the game menu to the screen.
//  @date April 6, 2020

import 'package:flutter/material.dart';
import 'GameBoardController.dart';

/// @brief Home class encapsulates the details for the menu screen when the game is launched.
class Home extends StatelessWidget {
  @override

  /// @brief Scaffold widget builds the layout for the home page components.
  //  @param context - indicates where the build is taking place.
  //  @return Scaffold widget with different components.
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          
          children: <Widget>[

            /// @brief Container to build the background using an image.
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/wood.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            /// @brief Text element to specify font size and alignment of the title.
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Text('Welcome to Mastermind',
                  style: TextStyle(fontSize: 35.0, color: Colors.white70, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            
             /// @brief Container defined to display the rules
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/rules.jpg"),
                    )
                  )
                ),
              ),
            ),
            
            /// @brief RaisedButton that launches the a new game board when pressed
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: RaisedButton.icon(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => gameBoard()));},
                  icon: Icon(Icons.play_circle_outline),
                  label: Text('Start Game',style: TextStyle(fontSize: 23)),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                ),
              ),
            ),    
          ],
        )
    );
  }
}