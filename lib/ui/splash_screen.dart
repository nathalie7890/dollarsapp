import 'package:dollar_app/ui/login.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset("assets/images/logo.png"),
          ),
          nunitoText("Dollar", 30, FontWeight.bold, primary),
          nunitoText("Keep track of your income and expenses", 17,
              FontWeight.w500, Colors.grey.shade500),
        ],
      ),
    );
  }
}
