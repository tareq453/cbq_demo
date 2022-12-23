import 'package:cbq/ui/pages/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/country_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/register_provider.dart';
import 'ui/pages/dashboard_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/register_page.dart';
import 'ui/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DashboardProvider(),
        )
      ],
      child: Consumer<RegisterProvider>(
        builder: (ctx, register, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: const Color(0xffb41a4e)),
                textTheme: ThemeData.light().textTheme.copyWith(
                    titleMedium: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    titleSmall: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    headlineSmall: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
            home: FutureBuilder(
              builder: (ctx, snapshot) {
                print("snapshot.data ${snapshot.data}");
                return snapshot.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : snapshot.data == true
                        ? const DashboardPage()
                        : const HomePage();
              },
              future: register.isRegistered(),
            ),
            routes: {
              LoginPage.route: (ctx) => const LoginPage(),
              RegisterPage.route: (ctx) => const RegisterPage(),
              PostDetail.route: (ctx) => const PostDetail(),
            },
          );
        },
      ),
    );
  }
}
