import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import "../../widgets/horizontal_divider.dart";
import '../../widgets/nunito_text.dart';

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  // visibility of date picker
  bool _datePickerDropDown = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();

  DateTime? _date;

// value of date picker
  void _onDateSelected(DateRangePickerSelectionChangedArgs args) {
    final DateTime selectedDate = args.value is DateTime
        ? args.value
        : (args.value as PickerDateRange).startDate;

    setState(() {
      _date = selectedDate;
    });

    debugPrint('Selected Date: ${selectedDate.toString()}');
  }

  // convert datetime to date
  String getDateFromDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
    return formattedDate;
  }

  String? selectedValue;

// onChange for category input
  void _categoryOnChange(String? value) {
    setState(() {
      selectedValue = value ?? '';
    });
  }

// drop down options for category drop down
  List<String> dropdownItems = [
    'Grocery',
    'Transport',
    'Entertainment',
    "Food",
    "Bills",
    "Clothing"
  ];

  // image upload
  bool hasImage = false;

  _onTapImageUpload() {
    setState(() {
      hasImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title input
                _transInput("Title", _title),
                const SizedBox(height: 15),

                // date dropdown
                nunitoText("Date", 15, FontWeight.bold, Colors.grey.shade700),
                const SizedBox(height: 10),
                _dateRow(),
                const SizedBox(height: 10),
                _datePickerDropDown ? _datePicker() : Container(),
                divider(color: Colors.grey.shade500),

                // category dropdown
                nunitoText(
                    "Category", 15, FontWeight.bold, Colors.grey.shade700),
                _categoryDropDown(),
                const SizedBox(height: 15),

                // note input
                _transInput("Note (Optional)", _note),
                const SizedBox(height: 15),

                // upload image
                nunitoText("Image (Optional)", 15, FontWeight.bold,
                    Colors.grey.shade700),
                const SizedBox(height: 15),
                hasImage
                    ? Image.asset("assets/images/receipt_1.png")
                    : _imageUpload(context),
                const SizedBox(height: 15),
                // add transation button
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: _addBtn())
              ],
            )),
      ),
    );
  }

  GestureDetector _imageUpload(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapImageUpload();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroIcon(
              HeroIcons.photo,
              color: Colors.grey.shade500,
              size: 50,
            ),
            nunitoText(
                "Upload an image", 15, FontWeight.w500, Colors.grey.shade700)
          ],
        ),
      ),
    );
  }

// upload image btn
  ElevatedButton _addBtn() {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: nunitoText("Add Transaction", 15, FontWeight.w500, tertiary));
  }

// displays title Date with down icon btn
  Row _dateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nunitoText(_date != null ? getDateFromDateTime(_date!) : "Select date",
            17, FontWeight.w500, primary),
        GestureDetector(
          onTap: () {
            setState(() {
              _datePickerDropDown = !_datePickerDropDown;
            });
          },
          child: const HeroIcon(
            HeroIcons.chevronDown,
            size: 15,
          ),
        )
      ],
    );
  }

// category dropdown
  DropdownButtonFormField<String> _categoryDropDown() {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: nunitoText("Select a category", 17, FontWeight.w500, primary),
      onChanged: (value) {
        if (value != null) {
          // Only update the selected value if it's not null
          _categoryOnChange(value);
        }
      },
      style: GoogleFonts.nunito(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
        ),
      ),
      icon: const HeroIcon(HeroIcons.chevronDown, size: 15),
      items: dropdownItems.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(value),
          ),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return dropdownItems.map<Widget>((String value) {
          return Container(
              child: nunitoText(value, 15, FontWeight.w500, primary));
        }).toList();
      },
    );
  }

// date picker
  Container _datePicker() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            10.0), // Adjust the radius as per your requirements
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: SfDateRangePicker(
          onSelectionChanged: _onDateSelected,
          monthViewSettings:
              const DateRangePickerMonthViewSettings(firstDayOfWeek: 1)),
    );
  }

// transaction input
  Column _transInput(String title, TextEditingController controller) {
    return Column(
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
    );
  }
}
