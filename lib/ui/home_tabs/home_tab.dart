import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:go_router/go_router.dart';
import "../colors.dart";
import '../widgets/nunito_text.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  _goToTransaction() {
    context.push("/transaction");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText("Hello,", 25, FontWeight.w500, primary),
          nunitoText("Bob Marley", 25, FontWeight.w800, primary),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: primary,
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
              nunitoText("Sunday", 20, FontWeight.w500, Colors.grey.shade100),
              nunitoText(
                  "28th May 2023", 15, FontWeight.w500, Colors.grey.shade400),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: tertiary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          nunitoText("Income", 15, FontWeight.w700, primary),
                          const SizedBox(
                            height: 5,
                          ),
                          nunitoText(
                              "RM 346, 234", 20, FontWeight.w500, primary),
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
                          color: tertiary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          nunitoText("Expenses", 15, FontWeight.w700, primary),
                          const SizedBox(
                            height: 5,
                          ),
                          nunitoText(
                              "RM 67, 108", 20, FontWeight.w500, primary),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(height: 30),
          nunitoText("Recent transaction", 20, FontWeight.w600, primary),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _goToTransaction(),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: primary,
                            child: Icon(
                              FontAwesomeIcons.utensils,
                              color: tertiary,
                              size: 20.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              nunitoText("Hoshino Omakase", 15, FontWeight.w800,
                                  primary),
                              nunitoText(
                                  "14/10/2023", 13, FontWeight.w500, primary)
                            ],
                          ),
                          const Spacer(),
                          nunitoText("RM4.50", 15, FontWeight.w700, primary)
                        ],
                      )),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }

  // Text nunitoText(
  //     String text, double size, FontWeight weight, Color? color) {
  //   return Text(text,
  //       style: GoogleFonts.montserrat(
  //           fontSize: size, fontWeight: weight, color: color));
  // }
}
