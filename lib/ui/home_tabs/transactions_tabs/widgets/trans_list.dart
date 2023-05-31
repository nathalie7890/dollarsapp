import 'package:dollar_app/service/trans_service.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import '../../../../data/model/trans.dart';

// ui
import '../../../colors.dart';
import '../../../widgets/nunito_text.dart';
import '../../../widgets/delete_confirm_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/lists.dart';

// utils
import '../../../utils/utils.dart';

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

ListView transList(BuildContext context, List transactions, bool getAll) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      final trans = transactions[index];
      final id = trans.id;
      return GestureDetector(
          onTap: () => {goToTransDetails(context, id)},
          child: getAll ? transItem(trans) : deleteDismissible(context, trans));
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

ListView periodList(
    BuildContext context, List items, bool isIncome, String type) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      final total = item['total'];

      return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              type == "week"
                  ? weekMonthListTile(item)
                  : type == "month"
                      ? monthListTile(item)
                      : type == "year"
                          ? yearListTile(item)
                          : Container(),
              const Spacer(),
              nunitoText("+ RM $total", 15, FontWeight.w700,
                  isIncome ? Colors.blue.shade700 : expense_red)
            ],
          ));
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 15);
    },
  );
}

Column weekMonthListTile(dynamic item) {
  final title = item['week'];
  final range = item['range'];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      nunitoText(title, 15, FontWeight.w800, primary),
      nunitoText(range.toString(), 13, FontWeight.w500, primary)
    ],
  );
}

Text monthListTile(dynamic item) {
  final month = item['month'];
  return nunitoText(month, 15, FontWeight.w800, primary);
}

Text yearListTile(dynamic item) {
  final year = item['year'].toString();
  return nunitoText(year, 15, FontWeight.w800, primary);
}
