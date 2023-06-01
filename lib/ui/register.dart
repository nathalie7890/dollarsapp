import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/widgets/toast.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";

// ui
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';

// utils
import 'package:dollar_app/ui/utils/utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final auth = AuthService();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _usernameError = false;
  bool _emailError = false;
  bool _passError = false;
  bool _confirmPassError = false;

  bool _isLoading = false;

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

// go to login page
  _goToLogin(BuildContext context) {
    context.push("/login");
  }

// sign up
  _onSignupClicked() {
    if (_isValid()) {
      setState(() {
        _isLoading = true;
      });

      _singup().then((value) => {
            if (value == true)
              {
                auth
                    .login(_email.text, _password.text)
                    .then((value) => {context.go("/home")})
              }
            else
              {showToast("Email is already taken")},
            setState(() {
              _isLoading = false;
            })
          });
    }
  }

  Future<bool> _singup() async {
    return await auth.signup(_email.text, _password.text, _username.text);
  }

// validate every input
  bool _isValid() {
    setState(() {
      _usernameError = _username.text.length < 3;
      _emailError = !Utils.isEmailValid(_email.text);
      _passError = _password.text.length < 5;
      _confirmPassError = _confirmPassword.text != _password.text;
    });

    List<bool> boolList = [
      _usernameError,
      _emailError,
      _passError,
      _confirmPassError
    ];

    return !boolList.contains(true);
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
                  _isLoading
                      ? loadingSpinner(_controller)
                      : SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: _signupBtn(() {
                            _onSignupClicked();
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
