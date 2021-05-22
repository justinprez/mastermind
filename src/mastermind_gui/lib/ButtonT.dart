/// @file ButtonT.dart
//  @author Justin Prez, Harshil Modi, Justin Rosner
//  @brief Module that defines the buttons of the gameboard.
//  @date April 6, 2020

import 'package:flutter/material.dart';

/// @brief Class that defines the components of ButtonT.
class ButtonT extends StatefulWidget {
  final Color color;
  final double size;

  ButtonT({Key key, this.color, this.size}) : super(key: key);

  @override
  _ButtonTState createState() => _ButtonTState();

  /// @brief Method to get the color of the button
  Color get getColor{
    return color;
  }
}

/// @brief Class that defines the state and look of ButtonT.
class _ButtonTState extends State<ButtonT> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
    );
  }
}