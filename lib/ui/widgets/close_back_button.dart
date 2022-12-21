import 'package:flutter/material.dart';

class CloseBackButton extends StatelessWidget {
  const CloseBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        icon: const Icon(Icons.close));
  }
}
