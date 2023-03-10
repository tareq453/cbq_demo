import 'package:cbq/providers/dashboard_provider.dart';
import 'package:cbq/providers/register_provider.dart';
import 'package:cbq/res/AppContextExtension.dart';
import 'package:cbq/res/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DashboardAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DashboardAppBarState extends State<DashboardAppBar>
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

  void _logout(BuildContext context) {
    context.read<RegisterProvider>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: context.resources.color.primary),
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.2, 1],
          colors: [
            context.resources.color.primary,
            context.resources.color.primaryDark,
          ],
        ),
      )),
      elevation: 0,
      title: Row(children: [
        ClipOval(
          child: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print("profile image string ${snapshot.data}");
                return Image.asset(
                  snapshot.data ?? AppImages.qatarFlag,
                  fit: BoxFit.fill,
                  width: 35,
                  height: 35,
                );
              }
            },
            future: context.read<DashboardProvider>().getUserImage(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                  child: Text(
                'welcome',
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: context.resources.color.colorWhite),
              )),
              FittedBox(
                  child: Text('Mr. Tareq Alassah',
                      style: context.theme.textTheme.subtitle2?.copyWith(
                          color: context.resources.color.colorWhite)))
            ],
          ),
        ),
      ]),
      backgroundColor: Colors.transparent,
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
    );
  }
}
