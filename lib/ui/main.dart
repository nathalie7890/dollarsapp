import 'package:dollar_app/ui/login.dart';
import 'package:dollar_app/ui/register.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'home.dart';
import 'navigation.dart';

void main() {
  runApp(MyApp(
    initialRoute: "/home",
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
//   }
// }
