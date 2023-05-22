import 'package:flutter/material.dart';
import '../../../data/model/trans.dart';
import '../../../service/trans_service.dart';
import 'category_list.dart';

// ui
import '../../colors.dart';
import '../../widgets/nunito_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// utils
import '../../utils/utils.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final transService = TransactionService();
  List<Transaction> _expenses = [];
  String _selected = "monthly";
  String? _category;

  @override
  void initState() {
    super.initState();
    _fetchTransWithType();
  }

  Future _fetchTransWithType() async {
    final res =
        await transService.getTransWithType("expense", category: _category);

    if (res != null) {
      setState(() {
        _expenses = res;
      });
    }
  }

  _periodBtnClicked(value) {
    debugPrint(_selected);
    setState(() {
      _selected = value;
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
          _periodBtnRow(),
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
      itemCount: _expenses.length,
      itemBuilder: (context, index) {
        final expense = _expenses[index];
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
                _incomeTitleDate(expense),
                const Spacer(),
                _incomeAmount(expense)
              ],
            ));
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }

  Text _incomeAmount(Transaction income) {
    return nunitoText("- RM ${income.amount.toStringAsFixed(2)}", 15,
        FontWeight.w700, expense_red);
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

  Row _periodBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _periodButton("Weekly", "weekly"),
        const SizedBox(
          width: 4,
        ),
        _periodButton("Monthly", "monthly"),
        const SizedBox(
          width: 4,
        ),
        _periodButton("Yearly", "yearly"),
      ],
    );
  }

  Expanded _periodButton(String title, String value) {
    return Expanded(
        child: ElevatedButton(
      onPressed: () {
        _periodBtnClicked(value);
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black54, width: 1)),
          elevation: 0,
          backgroundColor: _selected == value ? tertiary : primary),
      child: nunitoText(
          title, 15, FontWeight.w600, _selected == value ? primary : tertiary),
    ));
  }
}
