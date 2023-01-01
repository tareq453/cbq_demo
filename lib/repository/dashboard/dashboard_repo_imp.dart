import 'package:cbq/data/remote/network/api_end_points.dart';
import 'package:cbq/data/remote/network/network_api_serivce.dart';
import 'package:cbq/di/getit.dart';
import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';
import 'package:cbq/repository/dashboard/dashboard_repo.dart';

class DashboardRepoImp implements DashboardRepo {
  late final NetworkApiService _networkApiService;

  DashboardRepoImp() {
    _networkApiService = getIt<NetworkApiService>();
  }

  @override
  Future<List<DashboardPost>> getDashboardPost() async {
    final List<DashboardPost> loadedDashboardPost = [];
    final extractedPostData = await _networkApiService.getResponse(
        endpoint: ApiEndPoints.userPost) as List<dynamic>?;

    if (extractedPostData == null) {
      return loadedDashboardPost;
    }

    for (var jsonResult in extractedPostData) {
      print("jsonResult $jsonResult");
      final dashboardPost = DashboardPost.fromJson(jsonResult);
      loadedDashboardPost.add(dashboardPost);
    }
    return loadedDashboardPost;
  }

  @override
  Future<List<DashboardUser>> getDashboardUsers() async {
    final List<DashboardUser> loadedDashboardUser = [];
    final extractedUsersData = await _networkApiService.getResponse(
        endpoint: ApiEndPoints.users) as List<dynamic>?;

    if (extractedUsersData == null) {
      return loadedDashboardUser;
    }

    for (var jsonResult in extractedUsersData) {
      print("jsonResult $jsonResult");
      final dashboardUser = DashboardUser.fromJson(jsonResult);
      loadedDashboardUser.add(dashboardUser);
    }
    return loadedDashboardUser;
  }

  @override
  Future<DashboardPost?> getPostById(int postId) async {
    DashboardPost? dashboardPost;
    final extractedData = await _networkApiService.getResponse(
        endpoint: "${ApiEndPoints.userPost}/$postId");

    if (extractedData == null) {
      return dashboardPost;
    }
    dashboardPost = DashboardPost.fromJson(extractedData);
    return dashboardPost;
  }

  @override
  Future<DashboardUser?> getUserById(int userId) async {
    DashboardUser? dashboardUser;
    final extractedData = await _networkApiService.getResponse(
        endpoint: "${ApiEndPoints.users}/$userId");

    if (extractedData == null) {
      return dashboardUser;
    }
    dashboardUser = DashboardUser.fromJson(extractedData);
    return dashboardUser;
  }
}
