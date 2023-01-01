import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';

class PostDetails {
  final DashboardPost? dashboardPost;
  final DashboardUser? dashboardUser;

  PostDetails({
    required this.dashboardPost,
    required this.dashboardUser,
  });
}
