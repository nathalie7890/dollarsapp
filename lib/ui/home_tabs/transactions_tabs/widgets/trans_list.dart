import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:go_router/go_router.dart";

import '../../../../data/model/trans.dart';
import '../../../colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/delete_confirm_dialog.dart';
import '../../../widgets/nunito_text.dart';

// delete income
Future onConfirmDelete(String id) async {
  final transService = TransactionService();
  await transService.deleteTrans(id);
}

goToTransDetails(BuildContext context, String? id) {
  if (id != null) {
    context.push("/transaction/$id");
  }
}

IconData getIconByValue(List<Map<String, dynamic>> categories, String value) {
  for (var category in categories) {
    if (category['value'] == value) {
      return category['icon']['iconData'];
    }
  }
  return FontAwesomeIcons.moneyBill; // Default icon if no match is found
}

ListView transList(BuildContext context, List transactions) {
  return ListView.separated(
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      final trans = transactions[index];
      final id = trans.id;
      return GestureDetector(
          onTap: () => {goToTransDetails(context, id)},
          child: deleteDismissible(context, trans));
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 15);
    },
  );
}

Dismissible deleteDismissible(BuildContext context, Transaction trans) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (dir) => {onConfirmDelete(trans.id ?? "")},
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
    child: transItem(trans),
  );
}

Container transItem(Transaction trans) {
  final title = trans.title;
  final date = trans.date;
  final category = trans.category;
  double amount = trans.amount;
  bool isIncome = trans.type == "income";

  return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          transIcon(category, isIncome),
          const SizedBox(
            width: 10,
          ),
          Expanded(flex: 3, child: transTitleDate(title, date)),
          Container(child: transAmount(amount, isIncome))
        ],
      ));
}

Text transAmount(double amount, bool isIncome) {
  return nunitoText(
      isIncome
          ? "+ RM ${amount.toStringAsFixed(2)}"
          : "- RM ${amount.toStringAsFixed(2)}",
      15,
      FontWeight.w700,
      isIncome ? Colors.blue.shade700 : expense_red);
}

Column transTitleDate(String title, DateTime date) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.nunito(
            fontSize: 15, color: primary, fontWeight: FontWeight.bold),
        softWrap: true,
        maxLines: 2,
      ),
      // nunitoText(title, 15, FontWeight.w800, primary),
      nunitoText(Utils.getDateFromDateTime(date), 13, FontWeight.w500, primary)
    ],
  );
}

CircleAvatar transIcon(String category, bool isIncome) {
  final IconData iconData =
      getIconByValue(isIncome ? incomeCategories : expenseCategories, category);
  return CircleAvatar(
    radius: 30,
    backgroundColor: primary,
    child: Icon(
      iconData,
      color: tertiary,
      size: 20.0,
    ),
  );
}

ListView weekList(BuildContext context, List transactions) {
  return ListView.separated(
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nunitoText("Week ${index + 1}", 15, FontWeight.w800, primary),
                  nunitoText("12/1/23 - 17/1/23", 13, FontWeight.w500, primary)
                ],
              ),
              const Spacer(),
              nunitoText("+ RM 281.95", 15, FontWeight.w700, primary)
            ],
          ));
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 15);
    },
  );
}
