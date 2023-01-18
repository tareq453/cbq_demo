import 'package:cbq/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/country.dart';
import '../../../providers/country_provider.dart';
import '../../bottomsheet/country_picker_modal.dart';

class MobileNumberInput extends StatefulWidget {
  final Function(Country) _countryHandler;
  final Function(String) _mobilePhoneHandler;

  const MobileNumberInput(this._countryHandler, this._mobilePhoneHandler,
      {Key? key})
      : super(key: key);

  @override
  State<MobileNumberInput> createState() => _MobileNumberInputState();
}

class _MobileNumberInputState extends State<MobileNumberInput> {
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = Provider.of<CountryProvider>(context, listen: false)
        .getDefaultCountry();
    widget._countryHandler(_selectedCountry);
    super.initState();
  }

  Widget _prefix(Country? selectedCountry) {
    print("selectedCountry $selectedCountry");
    return GestureDetector(
      onTap: () {
        _showCountryModal();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                selectedCountry?.image ?? "",
                fit: BoxFit.fill,
                width: 25,
                height: 25,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
            Text(selectedCountry?.code ?? "")
          ],
        ),
      ),
    );
  }

  void _showCountryModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      isScrollControlled: true,
      builder: (ctx) {
        return CountryPickerModal(_selectCountry);
      },
    );
  }

  void _selectCountry(Country country) {
    print("_selectCountry 2 country ${country.toJson()}");
    setState(() {
      _selectedCountry = country;
      widget._countryHandler(_selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: TextFormField(
        enableInteractiveSelection: false,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            hintStyle:  Theme.of(context).textTheme.bodyMedium,
            hintText: 'Mobile Number *',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: _prefix(_selectedCountry),
            border: const OutlineInputBorder(),
            labelText: 'Mobile Number *'),
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
        ],
        validator: (value) {
          if (value == null || value.isEmpty == true) {
            return 'This field is required';
          } else if (value.length < 8) {
            return 'Mobile number must be atleast 8 digits';
          }
          return null;
        },
        onSaved: (phoneNumber) {
          widget._mobilePhoneHandler(phoneNumber!);
        },
      ),
    );
  }
}