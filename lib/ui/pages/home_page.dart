import 'package:cbq/res/AppContextExtension.dart';
import 'package:cbq/ui/widgets/home/home_button.dart';
import 'package:cbq/ui/widgets/slide_route.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _registerRoute(BuildContext context) {
    print("_registerRoute");
    Navigator.of(context).push(SlideRoute(const RegisterPage()));
  }

  void _loginRoute(BuildContext context) {
    print("_loginRoute");
    Navigator.of(context).push(SlideRoute(const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.resources.strings.welcomeMessage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text("Mobile App"),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeButton(Icons.login, "Login", () {
                _loginRoute(context);
              }),
              HomeButton(
                Icons.app_registration,
                "Register",
                () {
                  _registerRoute(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
