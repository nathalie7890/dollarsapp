import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Widget _tabBarItem(String s) {
    return SizedBox(
        height: 35,
        child: Tab(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: bg, width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(s),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Transactions",
                style: GoogleFonts.montserrat(fontSize: 20)),
            centerTitle: true,
            backgroundColor: bg,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: Colors.white,
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), color: bg),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    unselectedLabelColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: -2),
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      _tabBarItem("Income"),
                      _tabBarItem("Expense"),
                    ]),
              ),
            ),
          ),
          body: const TabBarView(children: [Income(), Expenses()]),
        ));
  }
}
