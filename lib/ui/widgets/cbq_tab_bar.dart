import 'package:cbq/providers/navigation_provider.dart';
import 'package:cbq/res/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CBQTabBar extends StatefulWidget {
  const CBQTabBar({Key? key}) : super(key: key);

  @override
  State<CBQTabBar> createState() => _CBQTabBarState();
}

class _CBQTabBarState extends State<CBQTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.4, 0.2, 0.4],
          colors: [
            context.resources.color.primary,
            context.resources.color.primaryLight,
            context.resources.color.primary,
          ],
        ),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: TabBar(
        onTap: (index) {
          context.read<NavigationProvider>().changeTab(index);
        },
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
        labelStyle: context.theme.textTheme.titleSmall,
        tabs: [
          cbqTab(
              icon: Icons.other_houses_outlined,
              text: context.appLocalizations.accounts),
          cbqTab(
              icon: Icons.stacked_line_chart_outlined,
              text: context.appLocalizations.transfers),
          cbqTab(
              icon: Icons.phone_iphone_outlined,
              text: context.appLocalizations.payments),
          cbqTab(
              icon: Icons.wallet_giftcard_outlined,
              text: context.appLocalizations.rewards),
          cbqTab(
              icon: Icons.dialpad_outlined,
              text: context.appLocalizations.services),
        ],
        controller: tabController,
      ),
    );
  }

  Widget cbqTab({required IconData icon, required String text}) {
    return Container(
        height: 60,
        padding: const EdgeInsets.only(top: 8),
        child: Center(
          child: Column(children: [
            Icon(
              icon,
              size: 25,
            ),
            FittedBox(child: Text(text))
          ]),
        ));
  }
}
