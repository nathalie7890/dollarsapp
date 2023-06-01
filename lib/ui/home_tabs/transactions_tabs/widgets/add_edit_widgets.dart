import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/nunito_text.dart';

// income and expense type btns
Row typeBtns(String type, void Function() incomeBtnClicked,
    void Function() expenseBtnClicked) {
  return Row(
    children: [
      Expanded(
          child: SizedBox(
        height: 50,
        child: typeIconBtn(type, "income", "Income", incomeBtnClicked),
      )),
      const SizedBox(width: 8),
      Expanded(
          child: SizedBox(
        height: 50,
        child: typeIconBtn(type, "expense", "Expense", expenseBtnClicked),
      ))
    ],
  );
}

ElevatedButton typeIconBtn(
    String type, String condition, String title, Function() onPressed) {
  return ElevatedButton.icon(
      onPressed: onPressed,
      icon: type == condition
          ? const HeroIcon(
              HeroIcons.checkCircle,
              color: Colors.greenAccent,
              size: 17,
            )
          : Container(),
      style: ElevatedButton.styleFrom(
          backgroundColor: type == condition ? primary : Colors.grey.shade400,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17))),
      label: nunitoText(
          title, 15, FontWeight.w500, type == condition ? tertiary : primary));
}

// upload image box
GestureDetector imageUpload(BuildContext context, Function() onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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

// date row with date picker and toggle visibility btn
Widget dateRow(Function() onTap, DateTime date) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nunitoText(
            Utils.getDateFromDateTime(date), 17, FontWeight.w500, primary),
        const HeroIcon(
          HeroIcons.chevronDown,
          size: 15,
        )
      ],
    ),
  );
}

// category dropdown
DropdownButtonFormField<String> categoryDropDown(String category,
    Function(String? value) onChange, List<String> dropdownItems) {
  return DropdownButtonFormField<String>(
    value: category,
    hint: nunitoText("Select a category", 17, FontWeight.w500, primary),
    onChanged: (value) {
      if (value != null) {
        onChange(value);
      }
    },
    style: GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 17,
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
          child: Text(Utils.capitalize(value)),
        ),
      );
    }).toList(),
    selectedItemBuilder: (BuildContext context) {
      return dropdownItems.map<Widget>((String value) {
        return Container(
            child: nunitoText(
                Utils.capitalize(value), 17, FontWeight.w500, primary));
      }).toList();
    },
  );
}

// date picker
Container datePicker(
    Function(DateRangePickerSelectionChangedArgs) onDateSelected) {
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
        onSelectionChanged: onDateSelected,
        monthViewSettings:
            const DateRangePickerMonthViewSettings(firstDayOfWeek: 1)),
  );
}

// input
  Column transInput(String title, TextEditingController controller,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nunitoText(title, 15, FontWeight.bold, Colors.grey.shade700),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines: null,
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
