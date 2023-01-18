import 'package:cbq/data/remote/response/api_response.dart';
import 'package:cbq/data/remote/response/status.dart';
import 'package:cbq/models/dashboard_data.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:cbq/res/AppContextExtension.dart';
import 'package:cbq/ui/widgets/custom_error_widget.dart';
import 'package:cbq/ui/widgets/dashboard/dashboard_list.dart';
import 'package:cbq/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DashboardProvider>().fetchAndSetDashboardData();
    return Container(
      color: context.resources.color.primaryDark,
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: context.resources.color.colorWhite),
        child: Selector<DashboardProvider, ApiResponse<List<DashboardData>>>(
            builder: (context, apiResponse, child) {
              switch (apiResponse.status) {
                case null:
                case Status.LOADING:
                  return const LoadingWidget();
                case Status.COMPLETED:
                  return DashboardList(apiResponse.data);
                case Status.ERROR:
                  return CustomErrorWidget(apiResponse.message);
              }
            },
            selector: (_, dashboardProvider) => dashboardProvider.apiResponse),
      ),
    );
  }
}
