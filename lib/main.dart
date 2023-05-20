import 'package:flutter/material.dart';
import 'ui/navigation.dart';

// firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    initialRoute: "/login",
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
//   }
// }
