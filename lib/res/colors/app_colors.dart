import 'dart:ui';

import 'package:cbq/res/colors/base_colors.dart';
import 'package:flutter/material.dart';

class AppColors implements BaseColors{
  final Map<int, Color> _primary =
   {
    50:Color(0xffb41a4e).withOpacity(0.1),
    100:Color(0xffb41a4e).withOpacity(0.2),
    200:Color(0xffb41a4e).withOpacity(0.3),
    300:Color(0xffb41a4e).withOpacity(0.4),
    400:Color(0xffb41a4e).withOpacity(0.5),
    500:Color(0xffb41a4e).withOpacity(0.6),
    600:Color(0xffb41a4e).withOpacity(0.7),
    700:Color(0xffb41a4e).withOpacity(0.8),
    800:Color(0xffb41a4e).withOpacity(0.9),
    900:Color(0xffb41a4e).withOpacity(1.0),
  };



  @override
  MaterialColor get colorPrimary => MaterialColor(0xffb41a4e,_primary);

  @override
  MaterialColor get colorSecondary => Colors.amber;

  @override
  Color get colorPrimaryText => Colors.white;

  @override
  Color get colorSecondaryText => const Color(0xff3593FF);

  @override
  Color get colorWhite => const Color(0xffffffff);

  @override
  Color get colorBlack => const Color(0xff000000);

  @override
  Color get transparent => Colors.transparent;



}