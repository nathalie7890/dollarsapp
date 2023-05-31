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
    newMap["period"] = "Week ${i + 1}";
    newMap["range"] = combineFirstAndLast(weeks[i]);
    newMap["total"] = calculateTotals(weeks[i]);
    newMap['categoryTotals'] = calculateCategoryTotals(weeks[i]);
    result.add(newMap);
  }

  List<Map<String, dynamic>> reversed = result.reversed.toList();

  return reversed;
}

List<Map<String, dynamic>> sortByMonth(List<Transaction> transactions) {
  Map<String, Map<String, double>> monthCategoryTotalMap = {};

  for (var transaction in transactions) {
    String monthYear = '${transaction.date.month} ${transaction.date.year}';

    if (monthCategoryTotalMap.containsKey(monthYear)) {
      Map<String, double> categoryTotalMap = monthCategoryTotalMap[monthYear]!;
      categoryTotalMap[transaction.category] =
          (categoryTotalMap[transaction.category] ?? 0) + transaction.amount;
    } else {
      Map<String, double> categoryTotalMap = {};
      categoryTotalMap[transaction.category] = transaction.amount;
      monthCategoryTotalMap[monthYear] = categoryTotalMap;
    }
  }

  List<Map<String, dynamic>> result =
      monthCategoryTotalMap.entries.map((entry) {
    String month = _getMonthName(entry.key);
    Map<String, double> categoryTotalMap = entry.value;

    List<Map<String, dynamic>> categoryTotals = categoryTotalMap.entries
        .map((categoryEntry) => {
              'category': categoryEntry.key,
              'total': categoryEntry.value,
            })
        .toList();

    double total = categoryTotalMap.values.reduce((a, b) => a + b);

    return {
      'period': month,
      'total': total.toStringAsFixed(2),
      'categoryTotals': categoryTotals
    };
  }).toList();

  return result;
}

List<Map<String, dynamic>> sortByYear(List<Transaction> transactions) {
  Map<int, Map<String, double>> yearCategoryTotalMap = {};

  for (var transaction in transactions) {
    int year = transaction.date.year;

    if (yearCategoryTotalMap.containsKey(year)) {
      Map<String, double> categoryTotalMap = yearCategoryTotalMap[year]!;
      categoryTotalMap[transaction.category] =
          (categoryTotalMap[transaction.category] ?? 0) + transaction.amount;
    } else {
      Map<String, double> categoryTotalMap = {};
      categoryTotalMap[transaction.category] = transaction.amount;
      yearCategoryTotalMap[year] = categoryTotalMap;
    }
  }

  List<Map<String, dynamic>> result = yearCategoryTotalMap.entries.map((entry) {
    int year = entry.key;
    Map<String, double> categoryTotalMap = entry.value;

    List<Map<String, dynamic>> categoryTotals = [];
    for (var categoryEntry in categoryTotalMap.entries) {
      String category = categoryEntry.key;
      String rounded = categoryEntry.value.toStringAsFixed(2);
      double total = double.tryParse(rounded) ?? 0;

      categoryTotals.add({
        'category': category,
        'total': total,
      });
    }

    double total = categoryTotalMap.values.reduce((a, b) => a + b);

    return {
      'period': year,
      'total': total.toStringAsFixed(2),
      'categoryTotals': categoryTotals
    };
  }).toList();

  return result;
}

String _getMonthName(String monthYear) {
  List<String> parts = monthYear.split(' ');
  int month = int.parse(parts[0]);
  int year = int.parse(parts[1]);

  DateTime dateTime = DateTime(year, month);

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

List<Map<String, dynamic>> calculateCategoryTotals(
    List<Transaction> transactions) {
  List<Map<String, dynamic>> categoryTotalsList = [];
  Map<String, double> categoryTotals = {};

  for (var transaction in transactions) {
    if (categoryTotals.containsKey(transaction.category)) {
      (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    } else {
      categoryTotals[transaction.category] = transaction.amount;
    }
  }

  categoryTotals.forEach((category, total) {
    categoryTotalsList.add({
      'category': category,
      'total': total,
    });
  });

  return categoryTotalsList;
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

double getTotalAmountByYear(
    List<Transaction> transactions, String type, int year) {
  double totalAmount = 0;

  for (var transaction in transactions) {
    if (transaction.type == type && transaction.date.year == year) {
      totalAmount += transaction.amount;
    }
  }

  return totalAmount;
}
