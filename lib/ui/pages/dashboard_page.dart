import 'package:cbq/exceptions/connectivity_exception.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';
import '../widgets/dashboard_list.dart';

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
  var _isLoading = false;
  var _isInternetConnectionExist = true;

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
      _fetchData();
      _runNotificationAnimation();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<DashboardProvider>(context, listen: false)
          .fetchAndSetDashboardData();
      setState(() {
        _isInternetConnectionExist = true;
        _isLoading = false;
      });
    } on ConnectivityException catch (error) {
      print("error dashboard $error");
      setState(() {
        _isLoading = false;
        _isInternetConnectionExist = false;
      });
    } catch (error) {
      print("error dashboard $error");
      setState(() {
        _isLoading = false;
      });
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isInternetConnectionExist
              ? const DashboardList()
              : _noInternetConnectionWidget(),
    );
  }

  void _logout(BuildContext context) {
    Provider.of<RegisterProvider>(context, listen: false).logout();
  }

  Widget _noInternetConnectionWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "No Internet connection,\n please check you internet connection!!",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(onPressed: _fetchData, child: const Text("Retry")),
          )
        ],
      ),
    );
  }
}
