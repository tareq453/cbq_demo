import 'package:cbq/res/colors/app_colors.dart';
import 'package:cbq/res/dimensions/app_dimension.dart';
import 'package:cbq/res/strings/arabic_strings.dart';
import 'package:cbq/res/strings/english_strings.dart';
import 'package:cbq/res/strings/strings.dart';
import 'package:flutter/cupertino.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'ar':
        return ArabicStrings();
      default:
        return EnglishStrings();
    }
  }

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
