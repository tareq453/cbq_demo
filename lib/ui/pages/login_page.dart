import 'package:cbq/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

import '../widgets/close_back_button.dart';

class LoginPage extends StatelessWidget {
  static const String route = "/login_page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseBackButton(),
        title: FittedBox(
          child: Text(
            context.appLocalizations.login_using_password,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
