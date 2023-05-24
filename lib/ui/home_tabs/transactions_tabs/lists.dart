import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../colors.dart';

final List<Map<String, dynamic>> expenseCategories = [
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
    "title": "Recreation",
    "value": 'recreation',
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
  },
  {
    "title": "Medical",
    "value": "medical",
    "icon": {
      "iconData": FontAwesomeIcons.kitMedical,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  }
];

final List<Map<String, dynamic>> incomeCategories = [
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
    "title": "Salary/Wage",
    "value": "salary",
    "icon": {
      "iconData": FontAwesomeIcons.moneyBill,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Investment",
    "value": "investment",
    "icon": {
      "iconData": FontAwesomeIcons.moneyCheckDollar,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Passive Income",
    "value": 'passive',
    "icon": {
      "iconData": FontAwesomeIcons.coins,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
  {
    "title": "Bonus",
    "value": "bonus",
    "icon": {
      "iconData": FontAwesomeIcons.rainbow,
      "defaultColor": Colors.black54,
      "selectedColor": tertiary,
    },
  },
];

final List<Map<String, dynamic>> periods = [
  {"title": "All", "value": null},
  {"title": "Daily", "value": "daily"},
  {"title": "Weekly", "value": "weekly"},
  {"title": "Monthly", "value": "monthly"},
  {"title": "Yearly", "value": "yearly"}
];
