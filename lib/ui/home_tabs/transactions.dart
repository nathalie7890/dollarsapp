import 'package:dollar_app/ui/colors.dart';
import 'package:flutter/material.dart';

// tabs
import 'package:dollar_app/ui/home_tabs/transactions_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/income.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  // Widget _tabBarItem(String s) {
  //   return SizedBox(
  //       height: 35,
  //       child: Tab(
  //           child: Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(50),
  //             border: Border.all(color: bg, width: 1)),
  //         child: Align(
  //           alignment: Alignment.center,
  //           child: Text(s),
  //         ),
  //       )));
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: bg,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(50)),
                  child: TabBar(
                      unselectedLabelColor: tertiary,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: primary,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: tertiary),
                      tabs: [_tab("Income"), _tab("Expense")]),
                ),
              ),
            ),
          ),
          body: const TabBarView(children: [Income(), Expenses()]),
        ));
  }

  Tab _tab(String title) {
    return Tab(
      height: 35,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }
}
