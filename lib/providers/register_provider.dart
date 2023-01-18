import 'package:cbq/data/local/pref/app_pref.dart';
import 'package:cbq/models/country.dart';
import 'package:cbq/models/user.dart';
import 'package:cbq/res/images/app_images.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isRegistered = false;
  final AppPref _appPref;
  String _selectedCountryImage = AppImages.qatarFlag;

  RegisterProvider(this._appPref);

  bool get isLoading {
    return _isLoading;
  }

  bool get isRegistered {
    return _isRegistered;
  }

  String get selectedCountryImage {
    return _selectedCountryImage;
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

  void updateCountry(Country country) {
    _selectedCountryImage = country.image;
  }
}
