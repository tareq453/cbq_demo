import 'package:cbq/ui/widgets/slide_route.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _homeButton(BuildContext context, IconData buttonIcon,
      String buttonText, Function(BuildContext) clickHandler) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(90, 90),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () => clickHandler(context),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(
                  buttonIcon,
                  size: 35,
                ),
                Text(buttonText)
              ]))),
    );
  }

  void _registerRoute(BuildContext context) {
    Navigator.of(context).push(SlideRoute(const RegisterPage()));
  }

  void _loginRoute(BuildContext context) {
    Navigator.of(context).push(SlideRoute(const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome To Commercial Bank",
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
              _homeButton(context, Icons.login, "Login", _loginRoute),
              _homeButton(
                context,
                Icons.app_registration,
                "Register",
                _registerRoute,
              )
            ],
          )
        ],
      ),
    );
  }
}
