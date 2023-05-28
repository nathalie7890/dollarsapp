import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/loading.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "../../data/model/trans.dart" as trans_model;

// ui
import '../colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/utils.dart';

class Transaction extends StatefulWidget {
  final String id;

  const Transaction({super.key, required this.id});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final transService = TransactionService();
  late trans_model.Transaction trans;
  bool isLoading = true;
  bool _isIncome = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
    _fetchTrans();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<trans_model.Transaction?> _fetchTrans() async {
    final res = await transService.getTransactionById(widget.id);
    if (res != null) {
      setState(() {
        trans = res;
      });

      if (trans.type == "income") {
        _isIncome = true;
      }
    }
    setState(() {
      isLoading = false;
    });
    return null;
  }

  _onTapEdit(String id) async {
    var res = await context.push("/editTrans/$id");
    if (res == "true") {
      _fetchTrans();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        backgroundColor: primary,
      ),
      body: isLoading
          ? loadingSpinner(_controller)
          : SingleChildScrollView(
              child: Container(
                color: bg,
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _badge(_isIncome),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoText(trans.title, 28, FontWeight.bold, primary),
                        GestureDetector(
                          onTap: () {
                            _onTapEdit(widget.id);
                          },
                          child: Icon(
                            FontAwesomeIcons.pen,
                            size: 15,
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    ),
                    _divider(),
                    _transactionDetail(
                        "Amount",
                        _isIncome
                            ? "+ RM ${trans.amount.toStringAsFixed(2)}"
                            : "- RM ${trans.amount.toStringAsFixed(2)}",
                        valueFontSize: 20,
                        color: _isIncome
                            ? Colors.blue.shade700
                            : Colors.red.shade700),
                    _divider(),
                    _transactionDetail(
                      "Date/Time",
                      Utils.getDateFromDateTime(trans.date),
                    ),
                    _divider(),
                    _transactionDetail(
                      "Category",
                      Utils.capitalize(trans.category),
                    ),
                    _divider(),
                    nunitoText("Note:", 17, FontWeight.w500, primary),
                    const SizedBox(
                      height: 5,
                    ),
                    trans.note == null
                        ? nunitoText("No note for this transaction.", 18,
                            FontWeight.w500, primary)
                        : nunitoText(
                            trans.note ?? "", 18, FontWeight.w500, primary),
                    _divider(),
                    nunitoText("Image:", 17, FontWeight.w500, primary),
                    trans.image == null
                        ? nunitoText("No image for this transaction.", 18,
                            FontWeight.w500, primary)
                        : Image.network(trans.image!)
                  ],
                ),
              ),
            ),
    );
  }

  Container _badge(bool isIncome) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isIncome ? Colors.blue.shade700 : expense_red),
      child: nunitoText(
          isIncome ? "Income" : "Expense", 15, FontWeight.w500, Colors.white),
    );
  }

  Row _transactionDetail(String title, String value,
      {double valueFontSize = 17, Color color = primary}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nunitoText(title, 17, FontWeight.w500, primary),
        nunitoText(value, valueFontSize, FontWeight.w500, color),
      ],
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 30,
    );
  }
}
