import 'package:flutter/material.dart';

abstract class BaseColors{
  //theme color
  MaterialColor get colorPrimary;
  MaterialColor get colorSecondary;

  Color get primary;
  Color get primaryDark;
  Color get primaryLight;
  //text color
  Color get colorPrimaryText;
  Color get colorSecondaryText;

  //extra color
  Color get colorWhite;
  Color get colorBlack;

  Color get transparent;
}