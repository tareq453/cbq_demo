import 'dart:convert';

import 'package:cbq/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider with ChangeNotifier {
  static const String USER_DATA_KEY = "user_data_key";

  Future<void> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    // final user = User(id: id, mobileNumber: mobileNumber, country: country);
    final userData = json.encode(user.toJson());
    prefs.setString(USER_DATA_KEY, userData);
    print('register user $user');
    print('register user number ${user.mobileNumber}');
    notifyListeners();
  }

  Future<bool> isRegistered() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print("USER_DATA_KEY ${prefs.containsKey(USER_DATA_KEY)}");
      if (prefs.containsKey(USER_DATA_KEY)) {
        print("data is ${prefs.get(USER_DATA_KEY)}");
        User? user =
            User.fromJson(json.decode(prefs.getString(USER_DATA_KEY) ?? ""));
        print("user ${user.toString()}");
        return user != null;
      } else {
        return false;
      }
    } catch (error) {
      print("error $error");
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // final user = User(id: id, mobileNumber: mobileNumber, country: country);
    prefs.remove(USER_DATA_KEY);
    notifyListeners();
  }
}
