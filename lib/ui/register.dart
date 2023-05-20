import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import "package:go_router/go_router.dart";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  bool _usernameError = false;
  bool _emailError = false;
  bool _passError = false;
  bool _confirmPassError = false;

  _goToLogin(BuildContext context) {
    context.push("/login");
  }

  _goToHome(BuildContext context) {
    context.push("/home");
  }

// sign up
  _signup() {
    _isValid();
    if (_isValid()) {
      context.push("/home");
    }
  }

// validate every input
  bool _isValid() {
    setState(() {
      _usernameError = _username.text.length < 3;
      _emailError = !isEmailValid(_email.text);
      _passError = _password.text.length < 5;
      _confirmPassError = _confirmPassword.text != _password.text;
    });

    List<bool> boolList = [
      _usernameError,
      _emailError,
      _passError,
      _confirmPassError
    ];

    return !boolList.every((bool value) => value);
  }

// check if email is valid
  bool isEmailValid(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return emailRegex.hasMatch(email);
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
                  nunitoText("Hello there,", 30, FontWeight.bold, primary),
                  nunitoText("Create your new account.", 20, FontWeight.w500,
                      Colors.grey.shade500),
                  const SizedBox(height: 30),

                  // username
                  _loginInput("Username", _username, false),
                  _invalidInput(_usernameError, "Invalid username"),
                  const SizedBox(height: 15),

                  // email
                  _loginInput("Email", _email, false),
                  _invalidInput(_emailError, "Invalid email"),
                  const SizedBox(height: 15),

                  // password
                  _loginInput("Password", _password, true),
                  _invalidInput(_passError, "Invalid password"),
                  const SizedBox(height: 15),

                  // confirm password
                  _loginInput("Confirm password", _confirmPassword, true),
                  _invalidInput(_confirmPassError, "Passwords don't match"),
                  const SizedBox(height: 20),

                  // sign up btn
                  SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: _signupBtn(() {
                        _signup();
                      })),
                  const SizedBox(height: 20),

                  // go to login
                  nunitoText("Already have an account?", 17, FontWeight.w500,
                      Colors.grey.shade700),
                  GestureDetector(
                      onTap: () {
                        _goToLogin(context);
                      },
                      child:
                          nunitoText("Log in.", 17, FontWeight.bold, primary)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

// invalid input msg
  Widget _invalidInput(bool error, String errorMessage) {
    return error
        ? nunitoText(errorMessage, 17, FontWeight.w500, expense_red)
        : Container();
  }

  // login btn
  ElevatedButton _signupBtn(void Function() onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: nunitoText("Sign up", 15, FontWeight.w500, tertiary));
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
