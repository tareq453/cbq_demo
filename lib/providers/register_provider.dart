import 'dart:convert';

import 'package:cbq/data/local/pref/app_pref.dart';
import 'package:cbq/di/getit.dart';
import 'package:cbq/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  final AppPref _appPref = getIt<AppPref>();

  bool get isLoading {
    return _isLoading;
  }

  Future<void> register(User user) async {
    _isLoading = true;
    notifyListeners();

    // for demo there is 2 seconds delay register.
    await Future.delayed(const Duration(seconds: 2));

    await _appPref.setUserData(user);
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> isRegistered() async {
    try {
      User? user = await _appPref.getUserData();
      return user != null;
    } catch (error) {
      print("error $error");
      return false;
    }
  }

  Future<void> logout() async {
    await _appPref.removeUserData();
    notifyListeners();
  }
}
