import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../data/model/trans.dart';

// Function to group transactions by week and calculate the total amount
List<Map<String, dynamic>> sortByWeek(List<Transaction> transactions) {
  // Sort the transactions by date in ascending order
  transactions.sort((a, b) => a.date.compareTo(b.date));

  List<Map<String, dynamic>> result = [];

  double totalAmount = 0;
  DateTime currentWeek = transactions[0]
      .date
      .subtract(Duration(days: transactions[0].date.weekday - 1));

  for (var transaction in transactions) {
    // Check if the transaction belongs to the current week
    if (transaction.date.difference(currentWeek).inDays >= 7) {
      // Format the date range as "start date - end date"
      String formattedDateRange =
          '${DateFormat('dd/MM/yyyy').format(currentWeek)} - ${DateFormat('dd/MM/yyyy').format(transaction.date)}';

      // Add the current week, formatted date range, and total amount to the result list
      result.add({
        'week': 'Week ${result.length + 1}',
        'range': formattedDateRange,
        'total': totalAmount.toStringAsFixed(2),
      });

      // Move to the next week
      currentWeek = transaction.date
          .subtract(Duration(days: transaction.date.weekday - 1));

      // Reset the total amount for the new week
      totalAmount = 0;
    }

    // Add the transaction amount to the total amount
    totalAmount += transaction.amount;
  }

  // Add the last week, formatted date range, and total amount to the result list
  String formattedDateRange =
      '${DateFormat('dd/MM/yyyy').format(currentWeek)} - ${DateFormat('dd/MM/yyyy').format(DateTime.now())}';
  result.add({
    'week': 'Week ${result.length + 1}',
    'range': formattedDateRange,
    'total': totalAmount.toStringAsFixed(2),
  });

  return List.from(result.reversed);
}

// Function to group transactions by month and calculate the total amount
List<Map<String, dynamic>> sortByMonth(List<Transaction> transactions) {
  debugPrint("Before sort: ${transactions.toString()}");
  // Sort the transactions by date in ascending order
  transactions.sort((a, b) {
    return b.date.compareTo(a.date); // Compare in descending order
  });

  debugPrint(transactions.toString());

  List<Map<String, dynamic>> result = [];

  double totalAmount = 0;
  int currentMonth = transactions[0].date.month;
  int currentYear = transactions[0].date.year;
  DateTime firstDateOfMonth = transactions[0].date;
  DateTime lastDateOfMonth = transactions[0].date;

  for (var transaction in transactions) {
    // Check if the transaction belongs to the current month
    if (transaction.date.month != currentMonth ||
        transaction.date.year != currentYear) {
      // Format the month and year as "Month Year"
      String formattedMonthYear =
          DateFormat('MMMM yyyy').format(DateTime(currentYear, currentMonth));

      // Format the date range as "dd/MM/yyyy - dd/MM/yyyy"
      String dateRange =
          '${DateFormat('dd/MM/yyyy').format(firstDateOfMonth)} - ${DateFormat('dd/MM/yyyy').format(lastDateOfMonth)}';

      // Add the current month, formatted month and year, date range, and total amount to the result list
      result.add({
        'month': formattedMonthYear,
        'range': dateRange,
        'total': totalAmount.toStringAsFixed(2),
      });

      // Move to the next month
      currentMonth = transaction.date.month;
      currentYear = transaction.date.year;
      firstDateOfMonth = transaction.date;
      lastDateOfMonth = transaction.date;

      // Reset the total amount for the new month
      totalAmount = 0;
    }

    // Update the last date of the month
    if (transaction.date.isAfter(lastDateOfMonth)) {
      lastDateOfMonth = transaction.date;
    }

    // Add the transaction amount to the total amount
    totalAmount += transaction.amount;
  }

  // Add the last month, formatted month and year, date range, and total amount to the result list
  String formattedMonthYear =
      DateFormat('MMMM yyyy').format(DateTime(currentYear, currentMonth));
  String dateRange =
      '${DateFormat('dd/MM/yyyy').format(firstDateOfMonth)} - ${DateFormat('dd/MM/yyyy').format(lastDateOfMonth)}';
  result.add({
    'month': formattedMonthYear,
    'range': dateRange,
    'total': totalAmount.toStringAsFixed(2),
  });

  return List.from(result.reversed);
}

double getTotalAmount(List<Transaction> transactions, String type) {
  double totalAmount = 0;
  
  for (var transaction in transactions) {
    if (transaction.type == type) {
      totalAmount += transaction.amount;
    }
  }
  
  return totalAmount;
}


