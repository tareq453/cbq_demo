import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _qidController = TextEditingController();

  Widget _perfix() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit_outlined));
  }

  Widget _mobileNumberText() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [BoxShadow()],
          ),
          child: Row(
            children: <Widget>[
              _perfix(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number *'),
                    controller: _qidController,
                    validator: (value) {
                      if (value?.isEmpty == true || value!.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Form(
        key: _formKey,
        child: Column(
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qatar ID/Passport Number *'),
                controller: _qidController,
                validator: (value) {
                  if (value?.isEmpty == true || value!.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    prefix: _perfix(),
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number *'),
                controller: _qidController,
                validator: (value) {
                  if (value?.isEmpty == true || value!.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {},
              ),
            ),
            _mobileNumberText()
          ],
        ),
      ),
    );
  }
}
