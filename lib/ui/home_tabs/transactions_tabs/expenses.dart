import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/trans_list.dart';
import 'package:flutter/material.dart';
import '../../../data/model/trans.dart';
import '../../../service/trans_service.dart';

// ui
import '../../colors.dart';
import '../../widgets/nunito_text.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/period_btn_row.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/category_btn_row.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> with SingleTickerProviderStateMixin {
   late AnimationController _controller;
  final transService = TransactionService();
  List<Transaction> _expenses = [];
  String? _period;
  String? _category;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
      _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
    _fetchTransWithType();
  }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


// fetch exense
  Future _fetchTransWithType() async {
    final res = await transService.getTransWithType(
        type: "expense", category: _category);

    if (res != null) {
      setState(() {
        _expenses = res;
        _isLoading = false;
      });
    }
  }

// select category
  _periodBtnClicked(value) {
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
      child: _isLoading
          ? loadingSpinner(_controller)
          : Column(
              children: [
                // weekly monthly yearly btns
                SizedBox(
                  height: 40,
                  child: periodBtnRow(periods, _periodBtnClicked, _period),
                ),
                const SizedBox(
                  height: 15,
                ),
                // total income
                nunitoText("RM 2037.67", 25, FontWeight.w700, primary),
                const SizedBox(height: 20),

                // category btns
                SizedBox(
                    height: 40,
                    child: categoryBtnRow(
                        expenseCategories, _categoryBtnClicked, _category)),
                const SizedBox(
                  height: 30,
                ),

                // income list
                Expanded(
                  child: transList(context, _expenses, false),
                )
              ],
            ),
    );
  }
}
