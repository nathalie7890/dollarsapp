import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import "package:go_router/go_router.dart";
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _goToLogin(BuildContext context) {
    context.push("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: bg,
          child: Column(children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.3),
              padding: const EdgeInsets.only(bottom: 20, right: 50, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Dollars",
                    style: GoogleFonts.montserrat(
                        color: secondary,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Keep track of your income and expenses",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.7),
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
                    Text(
                      "Incorrect username or password.",
                      style: TextStyle(color: primary),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => {},
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: secondary),
                        labelStyle: TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondary, width: 2),
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
                        hintText: "Email",
                        hintStyle: TextStyle(color: secondary),
                        labelStyle: TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondary, width: 2),
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
                        hintStyle: TextStyle(color: secondary),
                        labelStyle: TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondary, width: 2),
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
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: secondary),
                        labelStyle: TextStyle(color: secondary),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: secondary),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondary, width: 2),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20),
                            backgroundColor: tertiary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: secondary),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _goToLogin(context);
                      },
                      child: Text(
                        "Already have an account?",
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
