import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../data/model/trans.dart';

class SortTrans {
  static List<Map<String, dynamic>> groupTransactionsByWeek(
      List<Transaction> transactions, String? category, String? type) {
    // Filter transactions based on category and type if provided
    List<Transaction> filteredTransactions = transactions;
    if (category != null) {
      filteredTransactions = filteredTransactions
          .where((transaction) => transaction.category == category)
          .toList();
    }
    if (type != null) {
      filteredTransactions = filteredTransactions
          .where((transaction) => transaction.type == type)
          .toList();
    }

    // Sort transactions by date in ascending order
    filteredTransactions.sort((a, b) => a.date.compareTo(b.date));

    // Group transactions by weeks
    Map<String, List<Transaction>> groupedTransactions = {};
    for (Transaction transaction in filteredTransactions) {
      String weekNumber = DateFormat('w').format(transaction.date);
      groupedTransactions.putIfAbsent(weekNumber, () => []);
      groupedTransactions[weekNumber]!.add(transaction);
    }

    // Calculate the total amount for each week and create a list of weeks
    List<Map<String, dynamic>> weeks = [];
    groupedTransactions.forEach((weekNumber, transactions) {
      double totalAmount = transactions
          .map((transaction) => transaction.amount)
          .reduce((a, b) => a + b);

      String startDate =
          DateFormat('dd/MM/yyyy').format(transactions.first.date);
      String endDate = DateFormat('dd/MM/yyyy').format(transactions.last.date);
      String weekTitle = 'Week $weekNumber';

      weeks.add({
        'title': weekTitle,
        'date': '$startDate - $endDate',
        'amount': 'RM ${totalAmount.toStringAsFixed(2)}',
      });
    });

    return weeks;
  }
}
