import 'dart:io';
import "package:intl/intl.dart";

class Utils {
  static String generateFileName(File file, String userId) {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String fileExtension = fileName.split('.').last;
    return '${userId}_profile_image.$fileExtension';
  }

  static bool isEmailValid(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return emailRegex.hasMatch(email);
  }

  static String getCurrentDayOfWeek() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

// 28 May 2023
  static String getCurrentDateFormatted() {
    DateTime now = DateTime.now();
    return DateFormat('d MMMM yyyy').format(now);
  }

// 2023-05-28
  static String getDateFromDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
    return formattedDate;
  }

  static String capitalize(String word) {
    return '${word[0].toUpperCase()}${word.substring(1)}';
  }
}
