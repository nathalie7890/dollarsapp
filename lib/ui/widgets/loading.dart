import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingSpinner(AnimationController controller,
    {double size = 50.0, Color color = Colors.black}) {
  return SpinKitFadingFour(color: color, size: size, controller: controller);
}
