import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  String? id;
  String uid;
  String title; //
  double amount; //
  DateTime date; //
  String category; //
  String type; //
  String? note; //
  String? image; //

  Transaction({
    this.id,
    required this.uid,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    this.note,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
      'note': note,
      'image': image,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      uid: map['uid'],
      title: map['title'],
      amount: map['amount'] as double,
      // date: (map['date'] as Timestamp).toDate(),
      date: _parseDate(map['date']),
      category: map['category'],
      type: map['type'],
      note: map['note'],
      image: map['image'],
    );
  }

  static DateTime _parseDate(dynamic dateValue) {
    if (dateValue is String) {
      return DateTime.parse(dateValue);
    } else if (dateValue is Timestamp) {
      return dateValue.toDate();
    } else {
      throw ArgumentError("Invalid date format");
    }
  }

  @override
  String toString() {
    return 'Transaction(uid: $uid, title: $title, amount: $amount, date: $date, category: $category, type: $type,note: $note, image: $image)';
  }
}
