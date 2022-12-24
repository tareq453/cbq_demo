import 'package:cbq/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';
import '../../providers/country_provider.dart';
import '../../providers/register_provider.dart';
import '../bottomsheet/country_picker_modal.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  User? _userDetails;

  void _updateCountry(Country country) {
    _userDetails = User(
        id: _userDetails?.id,
        mobileNumber: _userDetails?.mobileNumber,
        country: country);
  }

  void _updateMobileNumber(String phoneNumber) {
    _userDetails = User(
        id: _userDetails?.id,
        mobileNumber: phoneNumber,
        country: _userDetails?.country);
  }

  Future<void> _submitForm() async {
    print("validate ${_formKey.currentState?.validate()}");
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if (_userDetails != null) {
      final registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);
      try {
        await registerProvider
            .register(_userDetails!)
            .then((value) => Navigator.of(context).pop());
      } catch (error) {
        print('error');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Something went wrong, please try again later",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('');
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade500)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade300,
              width: double.infinity,
              child: Text(
                "ENTER DETAILS",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    border: OutlineInputBorder(),
                    labelText: 'Qatar ID/Passport Number *'),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'This field is required';
                  }
                  return null;
                },
                onSaved: (id) {
                  _userDetails = User(
                      id: id,
                      mobileNumber: _userDetails?.mobileNumber,
                      country: _userDetails?.country);
                },
              ),
            ),
            MobileNumberInput(_updateCountry, _updateMobileNumber),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      onPressed: _submitForm,
                      child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}

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
    setState(() {
      widget._countryHandler(_selectedCountry);
      _selectedCountry = country;
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
