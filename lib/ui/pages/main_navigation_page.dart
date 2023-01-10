import 'package:cbq/providers/navigation_provider.dart';
import 'package:cbq/ui/main_navigation/dashboard_page.dart';
import 'package:cbq/ui/main_navigation/empty_page.dart';
import 'package:cbq/ui/widgets/cbq_tab_bar.dart';
import 'package:cbq/ui/widgets/dashboard/dashboard_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigationPage extends StatelessWidget {
  MainNavigationPage({Key? key}) : super(key: key);

  final navigationList = const [
    DashboardPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage()
  ];

  final appBarList = <PreferredSizeWidget>[
    const DashboardAppBar(),
    AppBar(
      title: const Text("Empty"),
    ),
    AppBar(
      title: const Text("Empty"),
    ),
    AppBar(
      title: const Text("Empty"),
    ),
    AppBar(
      title: const Text("Empty"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var currentIndex = context.select<NavigationProvider, int>(
      (navigationProvider) => navigationProvider.currentIndex,
    );
    return Scaffold(
      appBar: appBarList[currentIndex],
      body: navigationList[currentIndex],
      bottomNavigationBar: const CBQTabBar(),
    );
  }
}
