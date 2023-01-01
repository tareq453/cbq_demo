import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final IconData buttonIcon;
  final String buttonText;
  final Function() clickHandler;

  const HomeButton(this.buttonIcon, this.buttonText, this.clickHandler,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(90, 90),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: clickHandler,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(
                  buttonIcon,
                  size: 35,
                ),
                Text(buttonText)
              ]))),
    );
  }
}
