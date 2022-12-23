import 'package:cbq/models/country.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/country_provider.dart';
import '../widgets/country_item.dart';

class CountryPickerModal extends StatelessWidget {
  final Function(Country) _selectHandler;
  const CountryPickerModal(this._selectHandler,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final countryData =
        Provider.of<CountryProvider>(context, listen: false).countryList;
    return SizedBox(
      height: mediaQuery.size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.grey,
            width: 35,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "SELECT PHONE CODE",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                final country = countryData[index];
                return CountryItem(_selectHandler,country);
              },
              itemCount: countryData.length,
            ),
          )
        ],
      ),
    );
  }


  // const Padding(
  // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  // child: TextField(
  // decoration: InputDecoration(
  // isDense: true,
  // prefixIcon: Icon(Icons.search),
  // hintText: 'Search Code',
  // border: OutlineInputBorder(),
  // labelText: 'Search Code'),
  // ),
  // ),
}
