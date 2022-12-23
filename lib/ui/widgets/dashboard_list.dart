import 'package:cbq/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_item.dart';

class DashboardList extends StatelessWidget {
  const DashboardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardData =
        Provider.of<DashboardProvider>(context).dashboardDataList;

    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return DashboardItem(
          dashboardData[index],
          key: ValueKey(dashboardData[index].dashboardUser?.id),
        );
      },
      itemCount: dashboardData.length,
    );
  }
}
