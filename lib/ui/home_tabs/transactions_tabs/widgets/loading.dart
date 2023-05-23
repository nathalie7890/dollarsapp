import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingSpinner(TickerProvider state, double size,
    {Color color = Colors.black}) {
  return SpinKitFadingFour(
      color: color,
      size: size,
      controller: AnimationController(
          vsync: state, duration: const Duration(milliseconds: 1200)));
}
