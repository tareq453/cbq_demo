import 'package:cbq/res/Resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);

  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);
}
