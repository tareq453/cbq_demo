import 'package:flutter/material.dart';

abstract class BaseColors{
  //theme color
  MaterialColor get colorPrimary;
  MaterialColor get colorSecondary;

  //text color
  Color get colorPrimaryText;
  Color get colorSecondaryText;

  //extra color
  Color get colorWhite;
  Color get colorBlack;

  Color get transparent;
}