import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../widgets/nunito_text.dart';

ListView categoryBtnRow(
    List categories, void Function(String?) onPressed, String? selected) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      final category = categories[index];
      var title = category["title"];
      var value = category["value"];
      var iconData = category["icon"]["iconData"];
      var defaultColor = category["icon"]["defaultColor"];
      var selectedColor = category["icon"]["selectedColor"];
      final isSelected = selected == value;

      return ElevatedButton.icon(
          onPressed: () {
            onPressed(value);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              backgroundColor: isSelected ? primary : Colors.grey.shade300),
          icon: Icon(
            iconData,
            color: isSelected ? selectedColor : defaultColor,
            size: 15,
          ),
          label: nunitoText(
              title, 15, FontWeight.w500, isSelected ? tertiary : primary));
      // return _categoryIcons(index);
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 5,
    ),
  );
}
