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
import 'package:syncfusion_flutter_charts/charts.dart';

// model
import '../../../data/model/trans.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final transService = TransactionService();

  late List<GDPData> _chartData;

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
    _chartData = getChartData();
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

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData("Oceania", 1223),
      GDPData("Africa", 434),
      GDPData("America", 9583),
      GDPData("Asia", 5743),
      GDPData("Europe", 6934),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      padding: const EdgeInsets.all(10),
      child: _isLoading
          ? loadingSpinner(_controller)
          : !_isLoading && _incomes.isEmpty
              ? emptyList()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // weekly monthly yearly btns
                      SizedBox(
                        height: 40,
                        child:
                            periodBtnRow(periods, _periodBtnClicked, _period),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      SfCircularChart(
                        tooltipBehavior: TooltipBehavior(enable: true),
                        legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            overflowMode: LegendItemOverflowMode.wrap),
                        series: <CircularSeries>[
                          PieSeries<Map<String, dynamic>, String>(
                              dataSource: _categoryTotals,
                              xValueMapper: (data, _) => data['category'],
                              yValueMapper: (data, _) => data['total'],
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ],
                      ),

                      // total income
                      nunitoText("RM $_total", 25, FontWeight.w700, primary),
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
                      _period == "weekly"
                          ? periodList(context, _weeklyIncome, true, "week")
                          : _period == "monthly"
                              ? periodList(
                                  context, _monthlyIncome, true, "month")
                              : _period == "yearly"
                                  ? periodList(
                                      context, _yearlyIncome, true, "year")
                                  : transList(context, _incomes, false)
                    ],
                  ),
                ),
    );
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
