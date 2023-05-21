import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';


// ui
import '../colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final String _note =
      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: bg,
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _badge(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  nunitoText("Hoshino Omakase", 28, FontWeight.bold, primary),
                  Icon(
                    FontAwesomeIcons.pen,
                    size: 15,
                    color: Colors.grey.shade700,
                  )
                ],
              ),
              _divider(),
              _transactionDetail("Amount", "- RM 103.57",
                  valueFontSize: 20, color: Colors.red.shade700),
              _divider(),
              _transactionDetail(
                "Date/Time",
                "16/02/2023",
              ),
              _divider(),
              _transactionDetail(
                "Category",
                "Food",
              ),
              _divider(),
              nunitoText("Note:", 17, FontWeight.w500, primary),
              const SizedBox(
                height: 5,
              ),
              nunitoText("No note for this transaction.", 18, FontWeight.w500,
                  primary),
              nunitoText(_note, 18, FontWeight.w500, primary),
              _divider(),
              nunitoText("Image:", 17, FontWeight.w500, primary),
              nunitoText("No image for this transaction.", 18, FontWeight.w500,
                  primary),
              Column(
                children: [
                  Image.asset('assets/images/receipt_1.png'),
                  Image.asset('assets/images/omakase.jpg')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: expense_red),
      child: nunitoText("Expense", 15, FontWeight.w500, Colors.white),
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
