import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dollar_app/service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '../data/model/trans.dart';
import '../ui/utils/utils.dart';

class TransactionService {
  final ref = firestore.FirebaseFirestore.instance.collection('transaction');

  Future<List<Transaction>?> getTransWithType({String? type,
      String? category, String? period}) async {
    try {
      final repo = AuthService();
      final user = repo.getCurrentUser();

      if (user != null) {
        final uid = user.uid;
       firestore.Query query = ref.where('uid', isEqualTo: uid);

        if (type != null) {
          query = query.where('type', isEqualTo: type);
        }

        if (category != null) {
          query = query.where('category', isEqualTo: category);
        }

        firestore.QuerySnapshot querySnapshot = await query.get();

        List<Transaction> transactions = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Transaction.fromMap(data);
        }).toList();

        // debugPrint(transactions.toString());
        debugPrint(transactions.length.toString());
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

  Future<bool> deleteTrans(String id) async {
    try {
  
      await ref.doc(id).delete();
      debugPrint('Transaction deleted successfully');
      return true;
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      return false;
    }
  }
}
