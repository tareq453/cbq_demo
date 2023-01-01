import 'package:cbq/ui/widgets/register/register_form.dart';
import 'package:flutter/material.dart';

import '../widgets/close_back_button.dart';

class RegisterPage extends StatelessWidget {
  static const String route = "/register_page";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseBackButton(),
        title: const Text("New Register"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: RegisterForm(),
      ),
    );
  }
}
