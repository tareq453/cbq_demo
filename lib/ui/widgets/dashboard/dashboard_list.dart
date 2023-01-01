import 'package:cbq/models/dashboard_data.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_item.dart';

class DashboardList extends StatelessWidget {
  final List<DashboardData>? _dashboardList;

  const DashboardList(this._dashboardList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return DashboardItem(
          _dashboardList?[index],
          key: ValueKey(_dashboardList?[index].dashboardUser?.id),
        );
      },
      itemCount: _dashboardList?.length ?? 0,
    );
  }
}
