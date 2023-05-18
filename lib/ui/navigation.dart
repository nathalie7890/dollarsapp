import 'package:dollar_app/ui/home.dart';
import 'package:dollar_app/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  final _routes = [
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(
        path: "/home", name: "home", builder: (context, state) => const Home()),
    GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) => const Register())
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MaterialApp.router(
          routerConfig:
              GoRouter(initialLocation: initialRoute, routes: _routes),
        ));
  }
}
