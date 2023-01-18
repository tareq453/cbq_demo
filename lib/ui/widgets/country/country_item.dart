import 'package:flutter/material.dart';

import '../../../models/country.dart';

class CountryItem extends StatelessWidget {
  final Country _country;
  final Function(Country) _selectHandler;

  const CountryItem(this._selectHandler,this._country, {Key? key}) : super(key: key);

  void _selectCountry(BuildContext context) {
    print("_selectCountry _country ${_country.toJson()}");
    _selectHandler(_country);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          _selectCountry(context);
        },
        child: Card(
          elevation: 0.2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    _country.image,
                    fit: BoxFit.fill,
                    width: 20,
                    height: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(_country.code),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(_country.name),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
