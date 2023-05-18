import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Income"),
    );
  }
}
