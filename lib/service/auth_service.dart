import 'dart:io';

import 'package:dollar_app/ui/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signup(email, password, displayName) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(displayName);
      }
      return true;
    } catch (e) {
      debugPrint("Register failed: ${e.toString()}");
      return false;
    }
  }

  Future<bool> login(email, password) async {
    try {
      final res = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = res.user;

      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Login failed: ${e.toString()}");
      return false;
    }
  }

  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  String getUid() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return "";
    }
  }

  Future logout() async {
    await auth.signOut();
  }

  Future<bool> updateUser(
      String username, String email, String password, File? imageFile) async {
    try {
      final user = getCurrentUser();
      if (user != null) {
        AuthCredential authCredential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(authCredential);
        await user.updateDisplayName(username);
        await user.updateEmail(email);
        // await user.updatePassword(password);

        if (imageFile != null) {
          String fileName = Utils.generateFileName(imageFile, user.uid);
          Reference storageReference =
              FirebaseStorage.instance.ref().child('profile_images/$fileName');

          UploadTask uploadTask = storageReference.putFile(imageFile);
          TaskSnapshot uploadSnapshot = await uploadTask.whenComplete(() {});

          String downloadURL = await uploadSnapshot.ref.getDownloadURL();

          // Update the user's photo URL in Firebase Authentication
          await user.updatePhotoURL(downloadURL);
        }
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Failed to update user: $e");
      return false;
    }
  }
}
