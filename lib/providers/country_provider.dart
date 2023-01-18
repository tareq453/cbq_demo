import 'package:cbq/res/images/app_images.dart';
import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryProvider with ChangeNotifier {
  final List<Country> _countryList = [
    Country("Qatar", "+974", AppImages.qatarFlag),
    Country("Palestine", "+970", AppImages.palestineFlag),
    Country("Lebanon", "+961", AppImages.lebanonFlag),
    Country("Jordan", "+962", AppImages.jordan),
  ];

  Country? _selectedCountry;

  List<Country> get countryList {
    return [..._countryList];
  }

  Country get selectedCountry {
    return _selectedCountry ?? countryList.first;
  }

  Country getDefaultCountry() {
    return countryList.first;
  }


}
