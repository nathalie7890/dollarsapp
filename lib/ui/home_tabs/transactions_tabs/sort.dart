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

List<Map<String, dynamic>> sortByMonth(List<Transaction> transactions) {
  // Create a map to store the total amount for each month
  Map<String, double> monthTotalMap = {};

  // Iterate over the transactions and calculate the total amount for each month
  for (var transaction in transactions) {
    // Get the month and year of the transaction's date
    String monthYear = '${transaction.date.month} ${transaction.date.year}';

    // Update the total amount for the corresponding month
    if (monthTotalMap.containsKey(monthYear)) {
      // Update the total amount for the corresponding month
      monthTotalMap[monthYear] =
          (monthTotalMap[monthYear] ?? 0) + transaction.amount;
    } else {
      monthTotalMap[monthYear] = transaction.amount;
    }
  }

  // Convert the monthTotalMap into a list of maps with 'month' and 'total' keys
  List<Map<String, dynamic>> result = monthTotalMap.entries.map((entry) {
    String month = _getMonthName(entry.key);
    String roundedTotal = entry.value.toStringAsFixed(2);
    double total = double.tryParse(roundedTotal) ?? 0;

    return {'month': month, 'total': total};
  }).toList();

  return result;
}

List<Map<String, dynamic>> sortByYear(
    List<Transaction> transactions) {
  // Create a map to store the total amount for each year
  Map<int, double> yearTotalMap = {};

  // Iterate over the transactions and calculate the total amount for each year
  for (var transaction in transactions) {
    // Get the year of the transaction's date
    int year = transaction.date.year;

    // Update the total amount for the corresponding year
    if (yearTotalMap.containsKey(year)) {
      (yearTotalMap[year] ?? 0) + transaction.amount;
    } else {
      yearTotalMap[year] = transaction.amount;
    }
  }

  // Convert the yearTotalMap into a list of maps with 'year' and 'total' keys
  List<Map<String, dynamic>> result = yearTotalMap.entries.map((entry) {
    int year = entry.key;
    double total = entry.value;

    return {'year': year, 'total': total};
  }).toList();

print(result);
  return result;
}

String _getMonthName(String monthYear) {
  // Extract the month and year from the 'monthYear' string
  List<String> parts = monthYear.split(' ');
  int month = int.parse(parts[0]);
  int year = int.parse(parts[1]);

  // Create a DateTime object with the month and year
  DateTime dateTime = DateTime(year, month);

  // Format the DateTime object to get the month name
  String monthName = DateFormat('MMMM yyyy').format(dateTime);

  return monthName;
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
