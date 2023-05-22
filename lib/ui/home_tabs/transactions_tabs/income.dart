import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/period_list.dart';
import 'package:flutter/material.dart';

// ui
import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// model
import '../../../data/model/trans.dart';

// utils
import 'package:dollar_app/ui/utils/utils.dart';
import 'category_list.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final transService = TransactionService();
  List<Transaction> _incomes = [];
  String? _period;
  String? _category;

  @override
  void initState() {
    super.initState();
    _fetchTransWithType();
  }

  Future _fetchTransWithType() async {
    final res =
        await transService.getTransWithType("income", category: _category);

    if (res != null) {
      setState(() {
        _incomes = res;
      });
    }
  }

  _periodBtnClicked(value) {
    debugPrint(_period);
    setState(() {
      _period = value;
    });
  }

  _categoryBtnClicked(value) {
    setState(() {
      _category = value;
    });

    _fetchTransWithType();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // weekly monthly yearly btns
          SizedBox(
            height: 40,
            child: _periodBtnRow(),
          ),
          const SizedBox(
            height: 15,
          ),

          // total income
          nunitoText("RM 2037.67", 25, FontWeight.w700, primary),
          const SizedBox(height: 20),

          // category btns
          SizedBox(
            height: 50,
            child: _categoryBtnRow(),
          ),
          const SizedBox(
            height: 30,
          ),

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

  ListView _periodBtnRow() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: periods.length,
      itemBuilder: (context, index) {
        final period = periods[index];
        var title = period["title"];
        var value = period["value"];
        final isSelected = _period == value;

        return ElevatedButton(
            onPressed: () {
              _periodBtnClicked(value);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: primary, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                backgroundColor: isSelected ? tertiary : primary),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: nunitoText(
                  title, 15, FontWeight.w500, isSelected ? primary : tertiary),
            ));
        // return _categoryIcons(index);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 5,
      ),
    );
  }

  ListView _categoryBtnRow() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        var title = category["title"];
        var value = category["value"];
        var iconData = category["icon"]["iconData"];
        var defaultColor = category["icon"]["defaultColor"];
        var selectedColor = category["icon"]["selectedColor"];
        final isSelected = _category == value;

        return ElevatedButton.icon(
            onPressed: () {
              _categoryBtnClicked(value);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: primary, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                backgroundColor: isSelected ? primary : Colors.grey.shade300),
            icon: Icon(
              iconData,
              color: isSelected ? selectedColor : defaultColor,
              size: 15,
            ),
            label: nunitoText(
                title, 15, FontWeight.w500, isSelected ? tertiary : primary));
        // return _categoryIcons(index);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 5,
      ),
    );
  }
}
