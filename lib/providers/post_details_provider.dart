import 'package:cbq/data/remote/response/api_response.dart';
import 'package:cbq/di/getit.dart';
import 'package:cbq/models/post_details.dart';
import 'package:cbq/repository/dashboard/dashboard_repo.dart';
import 'package:cbq/repository/dashboard/dashboard_repo_imp.dart';
import 'package:flutter/cupertino.dart';

class PostDetailsProvider with ChangeNotifier {
  final DashboardRepo _dashboardRepo = getIt<DashboardRepoImp>();
  ApiResponse<PostDetails> _apiResponse = ApiResponse.loading();

  ApiResponse<PostDetails> get apiResponse {
    return _apiResponse;
  }

  Future<void> fetchAndSetPostDetails(int postId, int userId) async {
    _apiResponse = ApiResponse.loading();
    // notifyListeners();
    try {
      final dashboardPost = await _dashboardRepo.getPostById(postId);
      final dashboardUser = await _dashboardRepo.getUserById(userId);
      if (dashboardUser != null && dashboardPost != null) {
        final postDetails = PostDetails(
            dashboardPost: dashboardPost, dashboardUser: dashboardUser);
        _apiResponse = ApiResponse.completed(postDetails);
        notifyListeners();
      } else {
        _apiResponse = ApiResponse.error("No Data Available");
        notifyListeners();
      }
    } catch (error) {
      print("error $error");
      _apiResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
