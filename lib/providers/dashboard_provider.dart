import 'dart:convert';

import 'package:cbq/models/dashboard_data.dart';
import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../exceptions/connectivity_exception.dart';

class DashboardProvider with ChangeNotifier {
  List<DashboardData> _dashboardDataList = [];

  List<DashboardData> get dashboardDataList {
    return [..._dashboardDataList];
  }

  Future<bool> fetchAndSetDashboardData() async {
    final urlPost = Uri.https("jsonplaceholder.typicode.com", "/posts");
    final urlUser = Uri.https("jsonplaceholder.typicode.com", "/users");

    try {
      final Connectivity _connectivity = Connectivity();
      ConnectivityResult result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        throw ConnectivityException(
            "No Internet connection, please check you internet connection!!");
      }else{
        final responseUser = await http.get(urlUser);
        final extractedUserData = jsonDecode(responseUser.body) as List<dynamic>?;

        final responsePost = await http.get(urlPost);
        final extractedPostData = jsonDecode(responsePost.body) as List<dynamic>?;

        if (extractedPostData == null || extractedUserData == null) {
          return false;
        }

        final List<DashboardPost> loadedDashboardPost = [];
        final List<DashboardData> loadedDashboardData = [];

        for (var jsonResult in extractedPostData) {
          print("jsonResult $jsonResult");
          final dashboardPost = DashboardPost.fromJson(jsonResult);
          loadedDashboardPost.add(dashboardPost);
        }

        for (var jsonResult in extractedUserData) {
          print("jsonResult $jsonResult");
          final dashboardUser = DashboardUser.fromJson(jsonResult);
          loadedDashboardData.add(DashboardData(
              dashboardPostList: loadedDashboardPost
                  .where(
                      (dashboardPost) => dashboardPost.userId == dashboardUser.id)
                  .toList(),
              dashboardUser: dashboardUser));
        }
        _dashboardDataList = loadedDashboardData;
        notifyListeners();
      }
    } catch (error) {
      print("error 22 $error");
      rethrow;
    }
    return true;
  }

  DashboardUser? getDashboardUserById(int userId) {
    return _dashboardDataList
        .firstWhere(
            (dashboardData) => dashboardData.dashboardUser?.id == userId)
        .dashboardUser;
  }

  DashboardPost? getDashboardPostById(int postId, int userId) {
    final dashboardData = _dashboardDataList.firstWhere(
        (dashboardData) => dashboardData.dashboardUser?.id == userId);
    return dashboardData.dashboardPostList
        ?.firstWhere((dashboardPost) => dashboardPost.postId == postId);
  }
}
