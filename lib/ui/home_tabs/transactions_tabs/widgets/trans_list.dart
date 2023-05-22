import 'package:dollar_app/service/trans_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/model/trans.dart';
import '../../../colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/delete_confirm_dialog.dart';
import '../../../widgets/nunito_text.dart';

// delete income
Future _onConfirmDelete(String id) async {
  final transService = TransactionService();
  await transService.deleteTrans(id);
}

ListView transList(BuildContext context, List transactions) {
  return ListView.separated(
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      final trans = transactions[index];
      return _deleteDismissible(context, trans);
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 15);
    },
  );
}

Dismissible _deleteDismissible(BuildContext context, Transaction trans) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (dir) => {_onConfirmDelete(trans.id ?? "")},
    confirmDismiss: (dir) async {
      return await ConfirmDismissDialog.show(context);
    },
    background: Container(
      color: primary,
      child: Center(
        child: nunitoText("Removed", 20, FontWeight.w500, tertiary),
      ),
    ),
    secondaryBackground: Container(
      color: expense_red,
      child: Center(
          child: nunitoText("Remove", 20, FontWeight.w500, Colors.white)),
    ),
    child: _transItem(trans),
  );
}

Container _transItem(Transaction trans) {
  final title = trans.title;
  final date = trans.date;
  double amount = trans.amount;
  bool isIncome = trans.type == "income";

  return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          _transIcon(),
          const SizedBox(
            width: 10,
          ),
          _transTitleDate(title, date),
          const Spacer(),
          _transAmount(amount, isIncome)
        ],
      ));
}

Text _transAmount(double amount, bool isIncome) {
  return nunitoText(
      isIncome
          ? "+ RM ${amount.toStringAsFixed(2)}"
          : "- RM ${amount.toStringAsFixed(2)}",
      15,
      FontWeight.w700,
      isIncome ? Colors.blue.shade700 : expense_red);
}

Column _transTitleDate(String title, DateTime date) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      nunitoText(title, 15, FontWeight.w800, primary),
      nunitoText(Utils.getDateFromDateTime(date), 13, FontWeight.w500, primary)
    ],
  );
}

CircleAvatar _transIcon() {
  return CircleAvatar(
    radius: 30,
    backgroundColor: primary,
    child: Icon(
      FontAwesomeIcons.utensils,
      color: tertiary,
      size: 20.0,
    ),
  );
}
