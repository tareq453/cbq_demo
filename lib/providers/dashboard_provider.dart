import 'package:cbq/data/remote/response/api_response.dart';
import 'package:cbq/di/getit.dart';
import 'package:cbq/models/dashboard_data.dart';
import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';
import 'package:cbq/repository/dashboard/dashboard_repo.dart';
import 'package:cbq/repository/dashboard/dashboard_repo_imp.dart';
import 'package:flutter/material.dart';


class DashboardProvider with ChangeNotifier {
  final DashboardRepo _dashboardRepo = getIt<DashboardRepoImp>();
  ApiResponse<List<DashboardData>> _apiResponse = ApiResponse.loading();

  ApiResponse<List<DashboardData>> get apiResponse {
    return _apiResponse;
  }

  Future<bool> fetchAndSetDashboardData() async {
    try {
      _apiResponse = ApiResponse.loading();
      // notifyListeners();

      final List<DashboardPost> loadedDashboardPost =
          await _dashboardRepo.getDashboardPost();
      final List<DashboardUser> loadedDashboardUser =
          await _dashboardRepo.getDashboardUsers();
      final List<DashboardData> loadedDashboardData = [];

      for (var dashboardUser in loadedDashboardUser) {
        loadedDashboardData.add(DashboardData(
            dashboardPostList: loadedDashboardPost
                .where(
                    (dashboardPost) => dashboardPost.userId == dashboardUser.id)
                .toList(),
            dashboardUser: dashboardUser));
      }
      _apiResponse = ApiResponse.completed(loadedDashboardData);
      notifyListeners();
    } catch (error) {
      print("error 22 $error");
      _apiResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
    return true;
  }
}
