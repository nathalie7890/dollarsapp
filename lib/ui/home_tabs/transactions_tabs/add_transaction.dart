import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../widgets/nunito_text.dart';

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  TextEditingController _title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _transInput("Title", _title),
                const SizedBox(height: 15),
                // SfDateRangePicker(
                //   view: DateRangePickerView.year,
                // )
              ],
            )),
      ),
    );
  }

  Container _transInput(String title, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText(title, 15, FontWeight.bold, Colors.grey.shade700),
          TextField(
            controller: controller,
            style: GoogleFonts.nunito(
                color: primary, fontWeight: FontWeight.w600, fontSize: 17),
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primary)),
              hintText: title,
            ),
          ),
        ],
      ),
    );
  }
}
