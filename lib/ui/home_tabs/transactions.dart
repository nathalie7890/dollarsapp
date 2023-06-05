import 'package:dollar_app/ui/colors.dart';
import 'package:flutter/material.dart';

// tabs
import 'package:dollar_app/ui/home_tabs/transactions_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/income.dart';

class Transactions extends StatefulWidget {
  final String tabState;

  const Transactions({Key? key, required this.tabState}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex:
            widget.tabState != "expense" || widget.tabState.isEmpty ? 0 : 1);
  }

  @override
  void didUpdateWidget(covariant Transactions oldWidget) {
    _tabController.animateTo(widget.tabState != "expense" ? 0 : 1);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(kToolbarHeight), // Set the preferred height
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: primary,
          child: TabBar(
            controller: _tabController,
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
      body: TabBarView(
        controller: _tabController,
        children: const [Income(), Expenses()],
      ),
    );
  }
}
