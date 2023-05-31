import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/sort.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/emptyList.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/trans_list.dart';
import 'package:flutter/material.dart';

// ui
import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/period_btn_row.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/category_btn_row.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

// model
import '../../../data/model/trans.dart';
import '../../utils/utils.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  final transService = TransactionService();

  // income, weekly, monthly and yearly
  List<Transaction> _incomes = [];
  List<Map<String, dynamic>> _weeklyIncome = [];
  List<Map<String, dynamic>> _monthlyIncome = [];
  List<Map<String, dynamic>> _yearlyIncome = [];
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

// fetch income
  Future _fetchTransWithType() async {
    final res = await transService.getTransWithType(
        type: "income", category: _category);

    if (res != null && res.isNotEmpty) {
      setState(() {
        _incomes = res;
        _weeklyIncome = sortByWeek(_incomes);
        _monthlyIncome = sortByMonth(_incomes);
        _yearlyIncome = sortByYear(_incomes);
        _total = getTotalAmount(_incomes, "income");
        _total = double.tryParse(_total.toStringAsFixed(2)) ?? 0;
        _categoryTotals = calculateCategoryTotals(_incomes);
      });
    } else {
      setState(() {
        _incomes = [];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

// select period
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
          _categoryTotals = _weeklyIncome[index]['categoryTotals'];
          _total = _weeklyIncome[index]['total'];
        });
        break;

      case 'month':
        setState(() {
          _categoryTotals = _monthlyIncome[index]['categoryTotals'];
          _total = double.tryParse(_monthlyIncome[index]['total']) ?? 0;
        });
        break;

      case 'year':
        setState(() {
          _categoryTotals = _yearlyIncome[index]['categoryTotals'];
          _total = double.tryParse(_yearlyIncome[index]['total']) ?? 0;
        });
        break;

      default:
        //
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
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
                  !_isLoading && _incomes.isEmpty
                      ? Container()
                      : chart(_categoryTotals),

                  // total income
                  !_isLoading && _incomes.isEmpty
                      ? Container()
                      : nunitoText("RM $_total", 25, FontWeight.w700, primary),
                  const SizedBox(height: 20),

                  // category btns
                  SizedBox(
                    height: 40,
                    child: categoryBtnRow(
                        incomeCategories, _categoryBtnClicked, _category),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // income list
                  !_isLoading && _incomes.isEmpty
                      ? emptyList()
                      : _period == "weekly"
                          ? periodList(context, _weeklyIncome, true, "week",
                              _periodChartData)
                          : _period == "monthly"
                              ? periodList(context, _monthlyIncome, true,
                                  "month", _periodChartData)
                              : _period == "yearly"
                                  ? periodList(context, _yearlyIncome, true,
                                      "year", _periodChartData)
                                  : transList(context, _incomes, false)
                ],
              ),
            ),
    );
  }
}
