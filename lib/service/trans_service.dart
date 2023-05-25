import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dollar_app/service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../data/model/trans.dart';
import '../ui/utils/utils.dart';

class TransactionService {
  final ref = firestore.FirebaseFirestore.instance.collection('transaction');

  Future<List<Transaction>?> getTransWithType(
      {String? type, String? category, String? period}) async {
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

        query = query.orderBy('date', descending: true);

        firestore.QuerySnapshot querySnapshot = await query.get();

        List<Transaction> transactions = [];
        if (querySnapshot.docs.isNotEmpty) {
          transactions = querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return Transaction.fromMap(data);
          }).toList();
        }

        // debugPrint("Transaction: ${transactions.toString()}");
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

  // fetch one transaction with id
  Future<Transaction?> getTransactionById(String id) async {
    try {
      final snapshot = await ref.doc(id).get();

      if (snapshot.data() != null) {
        final transactionData = snapshot.data() as Map<String, dynamic>;
        final transaction = Transaction.fromMap(transactionData);
        transaction.id = snapshot.id; // Set the transaction ID

        return transaction;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error retrieving transaction: $e');
      return null;
    }
  }

  // delete everything this user has
  Future<void> deleteAllWithUid() async {
    try {
      final collectionRef =
          firestore.FirebaseFirestore.instance.collection('transactions');

      // Retrieve documents with matching UID
      final querySnapshot = await collectionRef
          .where('uid', isEqualTo: "39Et8vlpfZXqVfE0Nj2kInLWwN13")
          .get();

      // Delete documents
      final batch = firestore.FirebaseFirestore.instance.batch();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      debugPrint('Documents deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting documents: $e');
    }
  }

  // import sample data

  Future<void> importDataFromJson() async {
    final jsonString = await rootBundle.loadString('assets/sample_data.json');
    List<dynamic> data = jsonDecode(jsonString);

    for (var transactionData in data) {
      Transaction transaction = Transaction.fromMap(transactionData);
      debugPrint(transaction.toString());
      firestore.FirebaseFirestore.instance
          .collection('transaction') // Replace with your collection name
          .add(transaction.toMap())
          .then((value) {
        debugPrint('Transaction added successfully.');
      }).catchError((error) {
        debugPrint('Failed to add transaction: $error');
      });
    }
  }
}
