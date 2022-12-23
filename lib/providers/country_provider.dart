import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryProvider with ChangeNotifier {
  final List<Country> _countryList = [
    Country("Qatar", "+974", "assets/images/flags/flag-qatar.jpg"),
    Country("Palestine", "+970", "assets/images/flags/flag-palestine.jpg"),
    Country("Lebanon", "+961", "assets/images/flags/flag-lebanon.jpg"),
    Country("Jordan", "+962", "assets/images/flags/flag-jordan.jpg"),
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
