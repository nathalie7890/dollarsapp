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
  Map<String, double> monthTotalMap = {};

  for (var transaction in transactions) {
    String monthYear = '${transaction.date.month} ${transaction.date.year}';

    if (monthTotalMap.containsKey(monthYear)) {
      monthTotalMap[monthYear] =
          (monthTotalMap[monthYear] ?? 0) + transaction.amount;
    } else {
      monthTotalMap[monthYear] = transaction.amount;
    }
  }

  List<Map<String, dynamic>> result = monthTotalMap.entries.map((entry) {
    String month = _getMonthName(entry.key);
    String roundedTotal = entry.value.toStringAsFixed(2);
    double total = double.tryParse(roundedTotal) ?? 0;

    return {'month': month, 'total': total};
  }).toList();

  return result;
}

List<Map<String, dynamic>> sortByYear(List<Transaction> transactions) {
  Map<int, double> yearTotalMap = {};

  for (var transaction in transactions) {
    int year = transaction.date.year;

    if (yearTotalMap.containsKey(year)) {
      (yearTotalMap[year] ?? 0) + transaction.amount;
    } else {
      yearTotalMap[year] = transaction.amount;
    }
  }

  List<Map<String, dynamic>> result = yearTotalMap.entries.map((entry) {
    int year = entry.key;
    double total = entry.value;

    return {'year': year, 'total': total};
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

List<Map<String, dynamic>> calculateCategoryTotals(List<Transaction> transactions) {
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
