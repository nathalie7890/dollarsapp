import 'dart:ffi';

import 'package:dollar_app/ui/colors.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/horizontal_divider.dart';
import '../widgets/nunito_text.dart';

class Invest extends StatefulWidget {
  const Invest({super.key});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: bg,
            padding: const EdgeInsets.all(25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              nunitoText("Investment", 25, FontWeight.bold, primary),
              nunitoText("Never depend on a single income.", 16,
                  FontWeight.w500, Colors.grey.shade600),
              // divider(color: Colors.grey.shade600),
              const SizedBox(height: 20),
              investmentCard(true, "4.72%", "Monkey Unit Trust Fund"),
              const SizedBox(
                height: 18,
              ),
              investmentCard(false, '2.18%', "S&P 500"),
              const SizedBox(
                height: 18,
              ),
              investmentCard(true, '1.29%', "Ameera Saham")
            ])));
  }

  Container investmentCard(bool darkTheme, String returnRate, String title) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: darkTheme ? primary : Colors.blue.shade600,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  color: Colors.grey.shade800)
            ]),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nunitoText(title, 18, FontWeight.bold, Colors.grey.shade100),
              nunitoText("Low Risk", 15, FontWeight.w500,
                  darkTheme ? Colors.blue.shade300 : Colors.grey.shade100),
            ],
          ),
          const SizedBox(height: 20),
          nunitoText(returnRate, 25, FontWeight.w900,
              darkTheme ? Colors.blue.shade200 : bg),
          const SizedBox(width: 10),
          nunitoText("return per anum", 15, FontWeight.w500,
              darkTheme ? Colors.grey.shade500 : Colors.grey.shade300),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nunitoText("Invest from RM200", 15, FontWeight.w600,
                  Colors.grey.shade200),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          darkTheme ? Colors.blue.shade600 : primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: nunitoText("More", 15, FontWeight.w500, bg))
            ],
          )
        ]));
  }
}
