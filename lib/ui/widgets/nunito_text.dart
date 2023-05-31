import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text nunitoText(
  String text,
  double size,
  FontWeight weight,
  Color? color,
) {
  return Text(
    text,
    style: GoogleFonts.nunito(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ),
  );
}
