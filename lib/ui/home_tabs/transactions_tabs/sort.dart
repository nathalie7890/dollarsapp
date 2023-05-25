import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../data/model/trans.dart';
import '../../utils/utils.dart';

List<Map<String, dynamic>> sortByWeek(List<Transaction> transactions) {
  List<Transaction> sorted = List.from(transactions);
  sorted.sort((a, b) => a.date.compareTo(b.date));

  List<List<Transaction>> weeks = [];
  List<Transaction> currentWeek = [];

  for (int i = 0; i < sorted.length; i++) {
    if (currentWeek.isEmpty) {
      currentWeek.add(sorted[i]);
    } else {
      DateTime currentWeekStartDate = getStartOfWeek(currentWeek.first.date);
      DateTime transactionDate = sorted[i].date;

      if (transactionDate
          .isBefore(currentWeekStartDate.add(Duration(days: 7)))) {
        currentWeek.add(sorted[i]);
      } else {
        weeks.add(currentWeek);
        currentWeek = [sorted[i]];
      }
    }
  }

  if (currentWeek.isNotEmpty) {
    weeks.add(currentWeek);
  }

  List<Map<String, dynamic>> result = [];

  for (int i = 0; i < weeks.length; i++) {
    Map<String, dynamic> newMap = {};
    newMap["week"] = "Week ${i + 1}";
    newMap["range"] = combineFirstAndLast(weeks[i]);
    newMap["total"] = calculateTotals(weeks[i]);
    result.add(newMap);
  }
  List<Map<String, dynamic>> reversed = result.reversed.toList();
  return reversed;
}

List<String> sortByMonth(List<Transaction> transactions) {
  List<String> groupedMonths = [];

  for (Transaction transaction in transactions) {
    String monthYear =
        '${_getMonthName(transaction.date.month)} ${transaction.date.year}';

    if (!groupedMonths.contains(monthYear)) {
      groupedMonths.add(monthYear);
    }
  }
  print(groupedMonths);
  return groupedMonths;
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Unknown';
  }
}

DateTime getStartOfWeek(DateTime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

double calculateTotals(List<Transaction> period) {
  double totalAmount = 0.0;

  for (int i = 0; i < period.length; i++) {
    totalAmount += period[i].amount;
  }

  String roundedUp = totalAmount.toStringAsFixed(2);
  totalAmount = double.tryParse(roundedUp) ?? 0.0;
  return totalAmount;
}

String combineFirstAndLast(List<Transaction> list) {
  if (list.length == 1) {
    return Utils.getDateFromDateTime(list.first.date).toString();
  } else {
    String firstDate = Utils.getDateFromDateTime(list.first.date);
    String lastDate = Utils.getDateFromDateTime(list.last.date);
    return '$firstDate - $lastDate';
  }
}

double getTotalAmount(List<Transaction> transactions, String type, int year) {
  double totalAmount = 0;

  for (var transaction in transactions) {
    if (transaction.type == type && transaction.date.year == year) {
      totalAmount += transaction.amount;
    }
  }

  return totalAmount;
}
