import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
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

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final auth = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false;
  bool _emailError = false;
  bool _passError = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _goToRegister(BuildContext context) {
    context.push("/register");
  }

  _onLoginClicked() {
    if (_email.text.isEmpty) {
      setState(() {
        _emailError = true;
      });
      
      return;
    }

    if (_password.text.isEmpty) {
      setState(() {
        _passError = true;
      });

      return;
    }

    setState(() {
      _isLoading = true;
    });

    _login().then((value) => {
          if (value == true)
            {context.go("/home")}
          else
            {showToast("Incorrect username or password")},
          setState(() {
            _isLoading = false;
          })
        });
  }

  Future<bool> _login() async {
    return await auth.login(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.grey.shade100,
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

                // email
                _loginInput("Email", _email, false),
                _emailError
                    ? nunitoText(
                        "Email is required", 15, FontWeight.w500, expense_red)
                    : Container(),
                const SizedBox(height: 15),

                // password
                _loginInput("Password", _password, true),
                _passError
                    ? nunitoText("Password is required", 15, FontWeight.w500,
                        expense_red)
                    : Container(),
                const SizedBox(height: 30),

                // login btn
                _isLoading
                    ? loadingSpinner(_controller)
                    : SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: _loginBtn(() {
                          _onLoginClicked();
                        })),
                const SizedBox(height: 20),

                // create account btn
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
