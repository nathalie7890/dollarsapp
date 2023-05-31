import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/ui/widgets/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import "colors.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:dollar_app/ui/widgets/nunito_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  _goToRegister(BuildContext context) {
    context.push("/register");
  }

  _onLoginClicked() {
    _login().then((value) => {
          if (value == true)
            {context.push("/home")}
          else
            {showToast("Incorrect username or password")}
        });
  }

  Future<bool> _login() async {
    return await auth.login(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: bg,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  nunitoText("Welcome back,", 30, FontWeight.bold, primary),
                  nunitoText("Login to your account.", 20, FontWeight.w500,
                      Colors.grey.shade500),
                  const SizedBox(height: 30),
                  _loginInput("Email", _email, false),
                  const SizedBox(height: 15),
                  _loginInput("Password", _password, true),
                  const SizedBox(height: 30),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: _loginBtn(() {
                        _onLoginClicked();
                      })),
                  const SizedBox(height: 20),
                  nunitoText("Don't have an account?", 17, FontWeight.w500,
                      Colors.grey.shade700),
                  GestureDetector(
                      onTap: () {
                        _goToRegister(context);
                      },
                      child: nunitoText(
                          "Create one.", 17, FontWeight.bold, primary)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // login btn
  ElevatedButton _loginBtn(void Function() onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: nunitoText("Log in", 15, FontWeight.w500, tertiary));
  }

// login input
  TextField _loginInput(
      String title, TextEditingController controller, bool isPass) {
    return TextField(
      obscureText: isPass,
      controller: controller,
      style: GoogleFonts.nunito(
          color: primary, fontWeight: FontWeight.w600, fontSize: 17),
      decoration: InputDecoration(
        // enabledBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(width: 2, color: Colors.grey.shade500)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primary, width: 2)),
        hintText: title,
      ),
    );
  }
}
