import 'package:dollar_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'ui/navigation.dart';

// firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = AuthService();
  var user = auth.getCurrentUser();

  String initialRoute = user != null ? "/home" : "/login";

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
//   }
// }
