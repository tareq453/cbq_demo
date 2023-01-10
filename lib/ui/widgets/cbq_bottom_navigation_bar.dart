import 'package:cbq/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class CBQBottomNavigationBar extends StatelessWidget {
  const CBQBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.2, 0.8],
          colors: [
            context.resources.color.primary,
            context.resources.color.primaryDark,
          ],
        ),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.resources.color.transparent,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.other_houses_outlined),
              label: context.appLocalizations.accounts),
          BottomNavigationBarItem(
              icon: const Icon(Icons.stacked_line_chart_outlined),
              label: context.appLocalizations.transfers),
          BottomNavigationBarItem(
              icon: const Icon(Icons.phone_iphone_outlined),
              label: context.appLocalizations.payments),
          BottomNavigationBarItem(
              icon: const Icon(Icons.wallet_giftcard_outlined),
              label: context.appLocalizations.rewards),
          BottomNavigationBarItem(
              icon: const Icon(Icons.dialpad_outlined),
              label: context.appLocalizations.services),
        ],
      ),
    );
  }
}
