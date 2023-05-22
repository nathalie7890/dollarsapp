import 'package:dollar_app/ui/home.dart';
import 'package:dollar_app/ui/home_tabs/transaction.dart';
import 'package:dollar_app/ui/home_tabs/transactions.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/add_transaction.dart';
import 'package:dollar_app/ui/register.dart';
import 'package:dollar_app/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  final _routes = [
    GoRoute(path: "/splash", builder: (context, state) => const SplashScreen()),
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(path: "/", builder: (context, state) => const Home()),
    GoRoute(
        path: "/home", name: "home", builder: (context, state) => const Home()),
    GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) => const Register()),
    GoRoute(
        path: "/transaction",
        name: "transaction",
        builder: (context, state) => const Transaction()),
    GoRoute(
        path: "/addTrans",
        name: "addTrans",
        builder: (context, state) => const AddTrans()),
    // GoRoute(
    //     path: "/transactions/:tab",
    //     name: "transactions",
    //     builder: (context, state) {
    //       final tab = state.pathParameters['tab'] ?? 'income';
    //       int initialTabIndex = tab == "income" ? 0 : 1;
    //       return Transactions(initialTabIndex: initialTabIndex);
    //     }),
    GoRoute(
        path: "/home/:tab",
        name: "transactions",
        builder: (context, state) =>
            Home(tabState: state.pathParameters["tab"] ?? "")),
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
