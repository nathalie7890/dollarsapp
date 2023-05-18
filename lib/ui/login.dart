import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "colors.dart";
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _goToRegister(BuildContext context) {
    context.push("/register");
  }

  _goToHome(BuildContext context) {
    context.push("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: bg,
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Dollars.",
                    style: GoogleFonts.montserrat(
                        color: secondary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/images/wallet.png",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    "Sign in to your account",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade200,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(30.0), // Set the border radius here
                  color: primary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Incorrect username or password.",
                      style: TextStyle(color: tertiary),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => {},
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: const TextStyle(color: secondary),
                        labelStyle: const TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: secondary, width: 2),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) => {},
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: secondary),
                        labelStyle: const TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: secondary, width: 2),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _goToHome(context);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20),
                            backgroundColor: tertiary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: secondary),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _goToRegister(context);
                      },
                      child: const Text(
                        "Create a new account",
                        style: TextStyle(color: secondary),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
