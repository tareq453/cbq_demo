import 'package:cbq/res/colors/app_colors.dart';
import 'package:cbq/res/dimensions/app_dimension.dart';
import 'package:flutter/cupertino.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);


  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
