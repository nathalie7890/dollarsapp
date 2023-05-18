import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final List<String> _categories = [
    "Grocery",
    "Transport",
    "Entertainment",
    "Food",
    "Bills",
    "Clothing"
  ];
  final List<Icon> _icons = [
    const Icon(
      FontAwesomeIcons.carrot,
      color: Colors.black54,
      size: 15,
    ),
    const Icon(FontAwesomeIcons.headphones, color: Colors.black54, size: 15),
    const Icon(FontAwesomeIcons.bicycle, color: Colors.black54, size: 15),
    const Icon(FontAwesomeIcons.utensils, color: Colors.black54, size: 15),
    const Icon(FontAwesomeIcons.fileInvoiceDollar,
        color: Colors.black54, size: 15),
    const Icon(FontAwesomeIcons.shirt, color: Colors.black54, size: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _periodButton("Weekly", false),
              const SizedBox(
                width: 4,
              ),
              _periodButton("Monthly", true),
              const SizedBox(
                width: 4,
              ),
              _periodButton("Yearly", false),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.grey.shade300),
                    icon: _icons[index],
                    label: nunitoText(
                        _categories[index], 15, FontWeight.w500, primary));
                // return _categoryIcons(index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          nunitoText("RM 2037.67", 25, FontWeight.w700, primary),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
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
                    ));
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

  FloatingActionButton _categoryIcons(int index) {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.grey.shade300,
      child: _icons[index],
    );
  }

  Expanded _periodButton(String title, bool isSelected) {
    return Expanded(
        child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black54, width: 1)),
          elevation: 0,
          backgroundColor: isSelected ? tertiary : primary),
      child: nunitoText(
          title, 15, FontWeight.w600, isSelected ? primary : tertiary),
    ));
  }
}
