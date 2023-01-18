import 'package:cbq/di/getit.dart';
import 'package:cbq/providers/navigation_provider.dart';
import 'package:cbq/providers/post_details_provider.dart';
import 'package:cbq/res/AppContextExtension.dart';
import 'package:cbq/ui/pages/main_navigation_page.dart';
import 'package:cbq/ui/pages/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/country_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/register_provider.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/register_page.dart';
import 'ui/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("main rebuild");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => getIt<CountryProvider>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<RegisterProvider>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<DashboardProvider>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<PostDetailsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<NavigationProvider>(),
        )
      ],
      builder: (ctx, child) {
        return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'CBQ',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: context.resources.color.colorPrimary),
                textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: const TextStyle(fontWeight: FontWeight.bold),
                    titleMedium: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.resources.dimension.defaultText),
                    titleSmall: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.resources.dimension.smallText),
                    headlineSmall: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
            home: FutureBuilder(
              builder: (ctx, snapshot) {
                print("main snapshot.data $snapshot");
                return snapshot.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : const HomeDestination();
              },
              future: ctx.read<RegisterProvider>().checkRegistered(),
            ),
            routes: {
              LoginPage.route: (ctx) => const LoginPage(),
              RegisterPage.route: (ctx) => const RegisterPage(),
              PostDetail.route: (ctx) => const PostDetail(),
            });
      },
    );
  }
}

class HomeDestination extends StatelessWidget {
  const HomeDestination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("main HomeDestination");
    final isRegistered = context.select<RegisterProvider, bool>(
        (registerProvider) => registerProvider.isRegistered);
    return isRegistered ? MainNavigationPage() : const HomePage();
  }
}
