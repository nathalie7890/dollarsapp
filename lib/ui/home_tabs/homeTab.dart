import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import '../widgets/monserrat_text.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          montserratText("Hello,", 25, FontWeight.w500, Colors.black87),
          montserratText("Bob Marley", 25, FontWeight.w800, Colors.black87),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                      color: Colors.grey.shade800)
                ]),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              montserratText(
                  "Sunday", 20, FontWeight.w500, Colors.grey.shade100),
              montserratText(
                  "28th May 2023", 15, FontWeight.w500, Colors.grey.shade400),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          montserratText(
                              "Income", 15, FontWeight.w800, Colors.black87),
                          const SizedBox(
                            height: 8,
                          ),
                          montserratText("RM 346, 234", 20, FontWeight.w500,
                              Colors.black87),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          montserratText(
                              "Expenes", 15, FontWeight.w800, Colors.black87),
                          const SizedBox(
                            height: 8,
                          ),
                          montserratText("RM 67, 108", 20, FontWeight.w500,
                              Colors.black87),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(height: 30),
          montserratText(
              "Recent transaction", 20, FontWeight.w600, Colors.black87),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black87,
                          child: Icon(
                            FontAwesomeIcons.utensils,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            montserratText("Hoshino Omakase", 15,
                                FontWeight.w800, Colors.black87),
                            montserratText("Hoshino Omakase", 15,
                                FontWeight.w500, Colors.black87)
                          ],
                        )
                      ],
                    ));
              },
              separatorBuilder: (context, idnex) {
                return const SizedBox(height: 15);
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }

  // Text montserratText(
  //     String text, double size, FontWeight weight, Color? color) {
  //   return Text(text,
  //       style: GoogleFonts.montserrat(
  //           fontSize: size, fontWeight: weight, color: color));
  // }
}
