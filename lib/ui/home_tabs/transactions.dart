import 'package:dollar_app/ui/colors.dart';
import 'package:flutter/material.dart';

// tabs
import 'package:dollar_app/ui/home_tabs/transactions_tabs/expenses.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/income.dart';

class Transactions extends StatefulWidget {
  final String? tabState;
  final bool? refresh;

  const Transactions(
      {Key? key,
      this.tabState, this.refresh})
      : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState
    extends State<Transactions>
{
  
  late String tabState;
  late bool refresh;

  @override
  void initState() {
    super.initState();
    setState(() {
      tabState = widget.tabState ?? "";
      refresh = widget.refresh ?? false;
      debugPrint("transactions: $tabState");
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: tabState == "expense" ? 1 : 0,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
                kToolbarHeight), // Set the preferred height
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: primary,
              child: TabBar(
                // controller: _tabController,
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
          body: const TabBarView(
            // controller: _tabController,
            children: [Income(), Expenses()],
          ),
        ));
  }
}
