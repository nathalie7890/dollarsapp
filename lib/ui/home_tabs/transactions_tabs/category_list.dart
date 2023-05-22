import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../colors.dart';

final List<Map<String, dynamic>> categories = [
  {
    "title": "All",
    "value": null,
    "icon": {
      "iconData": FontAwesomeIcons.circle,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Grocery",
    "value": "grocery",
    "icon": {
      "iconData": FontAwesomeIcons.cartShopping,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Transport",
    "value": "transport",
    "icon": {
      "iconData": FontAwesomeIcons.bicycle,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Entertainment",
    "value": 'entertainment',
    "icon": {
      "iconData": FontAwesomeIcons.headphones,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Food",
    "value": "food",
    "icon": {
      "iconData": FontAwesomeIcons.utensils,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Bills",
    "value": "bills",
    "icon": {
      "iconData": FontAwesomeIcons.fileInvoiceDollar,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Clothing",
    "value": "clothing",
    "icon": {
      "iconData": FontAwesomeIcons.shirt,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  }
];
