import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview/home_page.dart';
import 'package:interview/login_page/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:interview/login_page/splash.dart';
import 'package:interview/utilits.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var email = prefs.getString('email');
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('hi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: email == null ? const MyApp() : const HomePage())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}

late SharedPreferences localStorage;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Future.delayed(const Duration(seconds: 5));
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(home: Splash());
          } else {
            // Loading is done, return the app:
            return MaterialApp(
              routes: {
                '/login': (context) => const MyApp(),
                '/homepage': (context) => const HomePage(),
              },
              theme: ThemeData(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,

              // locale: context.locale,
              home: const Scaffold(body: LoginPage()),
            );
          }
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
