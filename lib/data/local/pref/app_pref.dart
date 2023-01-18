import 'dart:convert';

import 'package:cbq/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const String USER_DATA_KEY = "user_data_key";

  Future<void> setUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(user.toJson());
    prefs.setString(USER_DATA_KEY, userData);
    print('register user $user');
    print('register user number ${user.mobileNumber}');
  }

  Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    print("USER_DATA_KEY ${prefs.containsKey(USER_DATA_KEY)}");
    if (prefs.containsKey(USER_DATA_KEY)) {
      print("data is ${prefs.get(USER_DATA_KEY)}");
      User? user =
          User.fromJson(json.decode(prefs.getString(USER_DATA_KEY) ?? ""));
      print("user ${user.toString()}");
      return user;
    } else {
      return null;
    }
  }

  Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    print("USER_DATA_KEY ${prefs.containsKey(USER_DATA_KEY)}");
    if (prefs.containsKey(USER_DATA_KEY)) {
      print("data is ${prefs.get(USER_DATA_KEY)}");
      User? user =
      User.fromJson(json.decode(prefs.getString(USER_DATA_KEY) ?? ""));
      print("user ${user.toString()}");
      return user.country?.image;
    } else {
      return null;
    }
  }

  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_DATA_KEY);
  }
}
