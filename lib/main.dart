import 'package:dollar_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'ui/navigation.dart';

// firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


// Project name: Dollar App (Tranck income and expense) 
// Team members: Joel and Nathalie

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
