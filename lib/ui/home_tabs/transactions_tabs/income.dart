import 'package:dollar_app/service/trans_service.dart';
import 'package:flutter/material.dart';

// ui
import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// model
import '../../../data/model/trans.dart';

// utils
import 'package:dollar_app/ui/utils/utils.dart';
import "categoryList.dart";

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final transService = TransactionService();
  List<Transaction> _incomes = [];

  @override
  void initState() {
    super.initState();
    _fetchTransWithType();
  }

  Future _fetchTransWithType() async {
    final res = await transService.getTransWithType("income");

    if (res != null) {
      setState(() {
        _incomes = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // weekly monthly yearly btns
          _periodBtnRow(),
          const SizedBox(
            height: 15,
          ),

          // category btns
          SizedBox(
            height: 50,
            child: _categoryBtnRow(),
          ),
          const SizedBox(
            height: 30,
          ),

          // total income
          nunitoText("RM 2037.67", 25, FontWeight.w700, primary),
          const SizedBox(height: 20),

          // income list
          Expanded(
            child: _incomeList(),
          )
        ],
      ),
    );
  }

  ListView _incomeList() {
    return ListView.separated(
      itemCount: _incomes.length,
      itemBuilder: (context, index) {
        final income = _incomes[index];
        return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                _incomeListIcon(),
                const SizedBox(
                  width: 10,
                ),
                _incomeTitleDate(income),
                const Spacer(),
                _incomeAmount(income)
              ],
            ));
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }

  Text _incomeAmount(Transaction income) {
    return nunitoText("+ RM ${income.amount.toStringAsFixed(2)}", 15,
        FontWeight.w700, Colors.blue.shade700);
  }

  Column _incomeTitleDate(Transaction income) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nunitoText(income.title, 15, FontWeight.w800, primary),
        nunitoText(Utils.getDateFromDateTime(income.date), 13, FontWeight.w500,
            primary)
      ],
    );
  }

  CircleAvatar _incomeListIcon() {
    return CircleAvatar(
      radius: 30,
      backgroundColor: primary,
      child: Icon(
        FontAwesomeIcons.utensils,
        color: tertiary,
        size: 20.0,
      ),
    );
  }

  ListView _categoryBtnRow() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                backgroundColor: Colors.grey.shade300),
            icon: categories[index].values.first,
            label: nunitoText(
                categories[index].keys.first, 15, FontWeight.w500, primary));
        // return _categoryIcons(index);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 5,
      ),
    );
  }

  Row _periodBtnRow() {
    return Row(
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
    );
  }

  Expanded _periodButton(String title, bool isSelected) {
    return Expanded(
        child: ElevatedButton(
      onPressed: () => {},
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
