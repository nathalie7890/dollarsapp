import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';

import '../../../colors.dart';
import '../../../widgets/nunito_text.dart';

Container emptyList() {
  return Container(
    padding: const EdgeInsets.all(25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 100,
        ),
        const SizedBox(height: 20),
        nunitoText("Such emptiness.", 22, FontWeight.bold, primary),
        Text(
            "Add a transaction by clicking the add button on the bottom tab bar!",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(color: primary, fontSize: 17)),
        const SizedBox(height: 20),
        const CircleAvatar(
          backgroundColor: primary,
          child: HeroIcon(
            HeroIcons.arrowDown,
            color: Colors.white,
            size: 15,
          ),
        )
      ],
    ),
  );
}
