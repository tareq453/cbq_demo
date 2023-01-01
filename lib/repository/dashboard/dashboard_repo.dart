import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';

abstract class DashboardRepo {
  Future<List<DashboardPost>> getDashboardPost();
  Future<List<DashboardUser>> getDashboardUsers();
  Future<DashboardUser?> getUserById(int userId);
  Future<DashboardPost?> getPostById(int postId);
}
