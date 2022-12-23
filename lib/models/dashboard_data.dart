import 'dashboard_post.dart';
import 'dashboard_user.dart';
class DashboardData {
  final List<DashboardPost>? dashboardPostList;
  final DashboardUser? dashboardUser;

  DashboardData(
      {required this.dashboardPostList,
      required this.dashboardUser,});

}
