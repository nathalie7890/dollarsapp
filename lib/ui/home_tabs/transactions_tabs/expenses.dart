import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/sort.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/emptyList.dart';
import 'package:dollar_app/ui/widgets/loading.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/trans_list.dart';
import 'package:flutter/material.dart';
import '../../../data/model/trans.dart';
import '../../../service/trans_service.dart';

// ui
import '../../colors.dart';
import '../../utils/utils.dart';
import '../../widgets/nunito_text.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/period_btn_row.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/category_btn_row.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  final transService = TransactionService();

  // expenses, weekly, monthly and yearly
  List<Transaction> _expenses = [];
  List<Map<String, dynamic>> _weeklyExpenses = [];
  List<Map<String, dynamic>> _monthlyExpenses = [];
  List<Map<String, dynamic>> _yearlyExpenses = [];
  List<Map<String, dynamic>> _categoryTotals = [];

  double _total = 0;

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

    if (res != null && res.isNotEmpty) {
      setState(() {
        _expenses = res;
        _weeklyExpenses = sortByWeek(_expenses);
        _monthlyExpenses = sortByMonth(_expenses);
        _yearlyExpenses = sortByYear(_expenses);
        _total = getTotalAmount(_expenses, "expense");
        _total = double.tryParse(_total.toStringAsFixed(2)) ?? 0;
        _categoryTotals = calculateCategoryTotals(_expenses);
      });
    } else {
      setState(() {
        _expenses = [];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

// select category
  _periodBtnClicked(value) {
    setState(() {
      _period = value;
      _category = null;
    });

    _fetchTransWithType();
  }

// select category
  _categoryBtnClicked(value) {
    setState(() {
      _category = value;
    });

    _fetchTransWithType();
  }

  void _periodChartData(String type, int index) {
    Utils.scrollToTop(_scrollController);

    switch (type) {
      case 'week':
        setState(() {
          _categoryTotals = _weeklyExpenses[index]['categoryTotals'];
          _total = _weeklyExpenses[index]['total'];
        });
        break;

      case 'month':
        setState(() {
          _categoryTotals = _monthlyExpenses[index]['categoryTotals'];
          _total = double.tryParse(_monthlyExpenses[index]['total']) ?? 0;
        });
        break;

      case 'year':
        setState(() {
          _categoryTotals = _yearlyExpenses[index]['categoryTotals'];
          _total = double.tryParse(_monthlyExpenses[index]['total']) ?? 0;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: _isLoading
          ? loadingSpinner(_controller)
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // weekly monthly yearly btns
                  SizedBox(
                    height: 40,
                    child: periodBtnRow(periods, _periodBtnClicked, _period),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // chart
                  !_isLoading && _expenses.isEmpty
                      ? Container()
                      : chart(_categoryTotals),

                  // total expenses
                  !_isLoading && _expenses.isEmpty
                      ? Container()
                      : nunitoText(
                          "- RM $_total", 25, FontWeight.w700, primary),
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
                  !_isLoading && _expenses.isEmpty
                      ? emptyList()
                      : _period == "weekly"
                          ? periodList(context, _weeklyExpenses, false, "week",
                              _periodChartData)
                          : _period == "monthly"
                              ? periodList(context, _monthlyExpenses, false,
                                  "month", _periodChartData)
                              : _period == 'yearly'
                                  ? periodList(context, _yearlyExpenses, false,
                                      "year", _periodChartData)
                                  : transList(context, _expenses, false)
                ],
              ),
            ),
    );
  }
}
