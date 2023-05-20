import 'package:flutter/material.dart';

Divider divider({Color? color}) {
  final dividerColor = color ?? Colors.grey.shade700;
  return Divider(
    color: dividerColor,
    thickness: 1,
    height: 20,
  );
}
