import 'package:cbq/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/country.dart';
import '../../../providers/register_provider.dart';
import 'mobile_number_input.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  User? _userDetails;

  void _updateCountry(Country country) {
    print("_updateCountry country ${country.toJson()}");
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

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() == false) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    if (_userDetails != null) {
      final registerProvider = context.read<RegisterProvider>();
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
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade500)),
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    border: const OutlineInputBorder(),
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
              child: context.select<RegisterProvider, bool>(
                      (registerProvider) => registerProvider.isLoading)
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: const Text("Submit")),
            ),
          ],
        ),
      ),
    );
  }
}
