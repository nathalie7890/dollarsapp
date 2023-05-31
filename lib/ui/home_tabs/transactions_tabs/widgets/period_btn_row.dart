import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../widgets/nunito_text.dart';

ListView periodBtnRow(
      List periods, void Function(String?) onPressed, String? selected) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: periods.length,
      itemBuilder: (context, index) {
        final period = periods[index];
        var title = period["title"];
        var value = period["value"];
        final isSelected = selected == value;

        return ElevatedButton(
            onPressed: () {
              onPressed(value);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: primary, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                backgroundColor: isSelected ? primary : tertiary),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: nunitoText(
                  title, 15, FontWeight.w500, isSelected ? tertiary : primary),
            ));
        // return _categoryIcons(index);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 5,
      ),
    );
  }