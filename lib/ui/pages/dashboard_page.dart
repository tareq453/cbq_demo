import 'package:cbq/data/remote/response/status.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:cbq/ui/widgets/custom_error_widget.dart';
import 'package:cbq/ui/widgets/dashboard/dashboard_list.dart';
import 'package:cbq/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late Animation<double> _rotationAnimation;
  late AnimationController _animationController;

  var _isInit = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -.1,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticIn));

    super.initState();
  }

  void _runNotificationAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      context.read<DashboardProvider>().fetchAndSetDashboardData();
      _runNotificationAnimation();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          RotationTransition(
            turns: _rotationAnimation,
            child: const Icon(Icons.notifications_active),
          ),
          IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
          switch (dashboardProvider.apiResponse.status) {
            case null:
            case Status.LOADING:
              return const LoadingWidget();
            case Status.COMPLETED:
              return DashboardList(dashboardProvider.apiResponse.data);
            case Status.ERROR:
              return CustomErrorWidget(dashboardProvider.apiResponse.message);
          }
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    context.read<RegisterProvider>().logout();
  }
}
