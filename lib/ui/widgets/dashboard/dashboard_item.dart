import 'package:cbq/res/AppContextExtension.dart';
import 'package:cbq/ui/pages/post_detail.dart';
import 'package:flutter/material.dart';

import '../../../models/dashboard_data.dart';

class DashboardItem extends StatefulWidget {
  final DashboardData? _dashboardData;

  const DashboardItem(this._dashboardData, {Key? key}) : super(key: key);

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem>
    with TickerProviderStateMixin {
  var _expanded = false;
  late Animation<double> _rotationAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Colors.grey)),
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.grey.shade100,
            title: Text(widget._dashboardData?.dashboardUser?.username ?? ''),
            trailing: IconButton(
              icon: RotationTransition(
                  turns: _rotationAnimation,
                  child: const Icon(Icons.expand_more)),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                  if (_expanded) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _expanded ? 300 : 0,
            curve: Curves.easeIn,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView.separated(
                  separatorBuilder: (BuildContext ctx, int index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final dashboardPost =
                        widget._dashboardData?.dashboardPostList?[0];
                    return GestureDetector(
                      onTap: () {
                        _navigateToPostDetail(
                            widget._dashboardData?.dashboardUser?.id ?? -1,
                            dashboardPost?.postId ?? -1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Text(dashboardPost?.title ?? "")),
                            const Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount:
                      widget._dashboardData?.dashboardPostList?.length ?? 0,
                )),
          )
        ],
      ),
    );
  }

  void _navigateToPostDetail(int userId, int postId) {
    var arg = {'userId': userId, 'postId': postId};
    Navigator.of(context).pushNamed(PostDetail.route, arguments: arg);
  }
}
