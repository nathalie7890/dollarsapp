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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
                kToolbarHeight), // Set the preferred height
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: primary,
              child: TabBar(
                tabs: const [
                  Tab(text: 'Income'),
                  Tab(text: 'Expense'),
                ],
                indicatorColor: tertiary,
                labelColor: tertiary,
                indicatorWeight: 1,
                labelStyle: const TextStyle(fontSize: 18),
                indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey.shade400,
              ),
            ),
          ),
          body: const TabBarView(children: [Income(), Expenses()]),
        ));
  }
}
