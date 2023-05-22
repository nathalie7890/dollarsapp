import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/trans_list.dart';
import 'package:flutter/material.dart';

// ui
import 'package:dollar_app/ui/colors.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/period_btn_row.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/category_btn_row.dart';

// model
import '../../../data/model/trans.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final transService = TransactionService();
  List<Transaction> _incomes = [];
  String? _period;
  String? _category;

  @override
  void initState() {
    super.initState();
    _fetchTransWithType();
  }

// fetch income
  Future _fetchTransWithType() async {
    final res =
        await transService.getTransWithType(type:"income", category: _category);

    if (res != null) {
      setState(() {
        _incomes = res;
      });
    }
  }

// select period
  _periodBtnClicked(value) {
    debugPrint(_period);
    setState(() {
      _period = value;
    });
  }

// select category
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
                incomeCategories, _categoryBtnClicked, _category),
          ),
          const SizedBox(
            height: 30,
          ),

          // income list
          Expanded(
            child: transList(context, _incomes),
          )
        ],
      ),
    );
  }

  // ListView _incomeList(BuildContext context, List transactions) {
  //   return ListView.separated(
  //     itemCount: transactions.length,
  //     itemBuilder: (context, index) {
  //       final trans = _incomes[index];
  //       return _deleteDismissible(context, trans);
  //     },
  //     separatorBuilder: (context, index) {
  //       return const SizedBox(height: 15);
  //     },
  //   );
  // }

  // Dismissible _deleteDismissible(BuildContext context, Transaction trans) {
  //   return Dismissible(
  //     key: UniqueKey(),
  //     onDismissed: (dir) => {_onConfirmDelete(trans.id ?? "")},
  //     confirmDismiss: (dir) async {
  //       return await ConfirmDismissDialog.show(context);
  //     },
  //     background: Container(
  //       color: primary,
  //       child: Center(
  //         child: nunitoText("Removed", 20, FontWeight.w500, tertiary),
  //       ),
  //     ),
  //     secondaryBackground: Container(
  //       color: expense_red,
  //       child: Center(
  //           child: nunitoText("Remove", 20, FontWeight.w500, Colors.white)),
  //     ),
  //     child: _incomeListItem(trans),
  //   );
  // }

  // Container _incomeListItem(Transaction trans) {
  //   return Container(
  //       padding: const EdgeInsets.all(15),
  //       decoration: BoxDecoration(
  //           color: Colors.grey.shade200,
  //           borderRadius: BorderRadius.circular(15)),
  //       child: Row(
  //         children: [
  //           _incomeListIcon(),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           _incomeTitleDate(trans),
  //           const Spacer(),
  //           _incomeAmount(trans)
  //         ],
  //       ));
  // }

  // Text _incomeAmount(Transaction trans) {
  //   return nunitoText("+ RM ${trans.amount.toStringAsFixed(2)}", 15,
  //       FontWeight.w700, Colors.blue.shade700);
  // }

  // Column _incomeTitleDate(Transaction trans) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       nunitoText(trans.title, 15, FontWeight.w800, primary),
  //       nunitoText(Utils.getDateFromDateTime(trans.date), 13, FontWeight.w500,
  //           primary)
  //     ],
  //   );
  // }

  // CircleAvatar _incomeListIcon() {
  //   return CircleAvatar(
  //     radius: 30,
  //     backgroundColor: primary,
  //     child: Icon(
  //       FontAwesomeIcons.utensils,
  //       color: tertiary,
  //       size: 20.0,
  //     ),
  //   );
  // }
}
