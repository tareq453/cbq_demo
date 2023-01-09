import 'package:cbq/data/local/pref/app_pref.dart';
import 'package:cbq/models/user.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isRegistered = false;
  final AppPref _appPref;

  RegisterProvider(this._appPref);

  bool get isLoading {
    return _isLoading;
  }

  bool get isRegistered {
    return _isRegistered;
  }

  Future<void> register(User user) async {
    _isLoading = true;
    notifyListeners();

    // for demo there is 2 seconds delay register.
    await Future.delayed(const Duration(seconds: 2));

    await _appPref.setUserData(user);
    _isLoading = false;
    _isRegistered = true;
    notifyListeners();
  }

  Future<void> checkRegistered() async {
    try {
      print("checkRegistered");
      User? user = await _appPref.getUserData();
      _isRegistered = user != null;
    } catch (error) {
      print("error $error");
      _isRegistered = false;
    }
  }

  Future<void> logout() async {
    await _appPref.removeUserData();
    _isRegistered = false;
    notifyListeners();
  }
}
