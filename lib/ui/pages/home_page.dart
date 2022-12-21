import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _homeButton(
      IconData buttonIcon, String buttonText, Function()? clickHandler) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(90, 90),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: clickHandler,
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

  void _register() {}

  void _login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome To Commercial Bank",style: Theme.of(context).textTheme.titleMedium,),
          const Text("Mobile App"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _homeButton(Icons.login, "Login", _login),
              _homeButton(
                Icons.app_registration,
                "Register",
                _register,
              )
            ],
          )
        ],
      ),
    );
  }
}
