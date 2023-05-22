import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dollar_app/service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '../data/model/trans.dart';
import '../ui/utils/utils.dart';

class TransactionService {
  final ref = firestore.FirebaseFirestore.instance.collection('transaction');

  Future<List<Transaction>?> getTransWithType(String type,
      {String? category, String? period}) async {
    try {
      final repo = AuthService();
      final user = repo.getCurrentUser();

      if (user != null) {
        final uid = user.uid;
        firestore.Query query =
            ref.where('uid', isEqualTo: uid).where('type', isEqualTo: type);

        if (category != null && period != null) {
          final now = DateTime.now();
          late DateTime startDate;

          if (period == 'weekly') {
            startDate = now.subtract(const Duration(days: 7));
          } else if (period == 'monthly') {
            startDate = now.subtract(const Duration(days: 30));
          } else if (period == 'yearly') {
            startDate = now.subtract(const Duration(days:  365));
          }

          query.where('category', isEqualTo: category).where('date',
              isGreaterThanOrEqualTo: firestore.Timestamp.fromDate(startDate));
        } else {
          if (category != null) {
            query.where('category', isEqualTo: category);
          }

          if (period != null) {
            final now = DateTime.now();
            late DateTime startDate;

            if (period == 'weekly') {
              startDate = now.subtract(const Duration(days: 7));
            } else if (period == 'monthly') {
              startDate = now.subtract(const Duration(days: 30));
            } else if (period == 'yearly') {
              startDate = now.subtract(const Duration(days: 365));
            }

            query.where('date',
                isGreaterThanOrEqualTo:
                    firestore.Timestamp.fromDate(startDate));
          }
        }

        firestore.QuerySnapshot querySnapshot = await query.get();

        List<Transaction> transactions = querySnapshot.docs
            .map((doc) =>
                Transaction.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        // debugPrint(transactions.toString());
        return transactions;
      }
    } catch (e) {
      debugPrint("Failed to fetch with type $e");
    }
    return null;
  }

  Future<bool> addTrans(Transaction transaction, File? imageFile) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        final fileName = Utils.generateFileName(imageFile, "");
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('transaction_images')
            .child(fileName);
        await storageRef.putFile(imageFile);
        imageUrl = await storageRef.getDownloadURL();
      }

      await ref.add({
        "uid": transaction.uid,
        'title': transaction.title,
        'amount': transaction.amount,
        'date': transaction.date,
        'category': transaction.category,
        'type': transaction.type,
        'note': transaction.note,
        'image': imageUrl,
      });

      debugPrint('Transaction saved successfully');
      return true;
    } catch (e) {
      debugPrint('Error saving transaction: $e');
      return false;
    }
  }
}
