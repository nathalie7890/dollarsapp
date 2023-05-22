import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dollar_app/service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '../data/model/trans.dart';
import '../ui/utils/utils.dart';

class TransactionService {
  final ref = firestore.FirebaseFirestore.instance.collection('transaction');

  Future<List<Transaction>?> getTransWithType(String type) async {
    try {
      final repo = AuthService();
      final user = repo.getCurrentUser();

      if (user != null) {
        final uid = user.uid;
        firestore.QuerySnapshot querySnapshot = await ref
            .where('uid', isEqualTo: uid)
            .where('type', isEqualTo: type)
            .get();

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
